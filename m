Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288624AbSATOZ2>; Sun, 20 Jan 2002 09:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSATOZS>; Sun, 20 Jan 2002 09:25:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:11230 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S288624AbSATOZE>; Sun, 20 Jan 2002 09:25:04 -0500
Date: Sun, 20 Jan 2002 15:23:52 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Momchil Velikov <velco@fadata.bg>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile
In-Reply-To: <874rlhazst.fsf@fadata.bg>
Message-ID: <Pine.NEB.4.44.0201201519460.20948-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2002, Momchil Velikov wrote:

> Hi there,
>
> The following patch fixes compilation/miscompilation problems, which
> may happend iwtg variuos cross compile configuration, wherte the
> compiler used to compile the kernel does not necessarily define
> __linux__. The patch replaces __linux__ with __KERNEL__, using

Isn't this a compiler bug?

> __KERNEL_ as an indication that the source is compiled as a part of
>...

This is definitely wrong in files that are not Linux-specific and that are
used on FreeBSD (and BSDI) as well (you would know that if you'd looked at
the files your patch changes)...

cu
Adrian


