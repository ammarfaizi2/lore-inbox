Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288776AbSATQEl>; Sun, 20 Jan 2002 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288782AbSATQEc>; Sun, 20 Jan 2002 11:04:32 -0500
Received: from [217.9.226.246] ([217.9.226.246]:11140 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288776AbSATQEZ>; Sun, 20 Jan 2002 11:04:25 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile
In-Reply-To: <Pine.NEB.4.44.0201201611030.20948-100000@mimas.fachschaften.tu-muenchen.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.NEB.4.44.0201201611030.20948-100000@mimas.fachschaften.tu-muenchen.de>
Date: 20 Jan 2002 18:04:13 +0200
Message-ID: <87k7ud9fgi.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:
Adrian> If your compiler is configured as a cross-compiler everything should work
Adrian> as expected. If you are trying to compile a Linux kernel with a gcc that
Adrian> is configured to build binaries for NetBSD this sounds evil.

Could you elaborate why ? I think people do it all the time, compiling
linux (which is not a _linux_ binary, but a i386, alpha, etc. binary)
with a compiler configured to compile linux binaries.

>> >> __KERNEL_ as an indication that the source is compiled as a part of
>> >> ...
>> 
Adrian> This is definitely wrong in files that are not Linux-specific and that are
Adrian> used on FreeBSD (and BSDI) as well (you would know that if you'd looked at
Adrian> the files your patch changes)...
>> 
>> *BSD define _KERNEL, don't they ?

Adrian> I don't know (I never tried to compile a *BSD kernel).
Adrian> But if yes please consider what the following parts of your patch change:

Adrian> -#ifndef __linux__
Adrian> +#ifndef __KERNEL__

I have. Have you ?

Regards,
-velco

