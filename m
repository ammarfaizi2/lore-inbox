Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265467AbRGHWwB>; Sun, 8 Jul 2001 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266031AbRGHWvv>; Sun, 8 Jul 2001 18:51:51 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9482 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265467AbRGHWvl>;
	Sun, 8 Jul 2001 18:51:41 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols in 2.4.6 
In-Reply-To: Your message of "Sun, 08 Jul 2001 09:20:46 EST."
             <008001c107b9$3011c660$66b93604@molybdenum> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Jul 2001 08:51:36 +1000
Message-ID: <24743.994632696@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 09:20:46 -0500, 
"Jahn Veach - Veachian64" <V64@Galaxy42.com> wrote:
>On Sun, 8 Jul 2001 03:23:17 -0600,
>"Keith Owens" <kaos@ocs.com.au> wrote:
>>What does 'grep printk /proc/ksyms' report on the 2.4.6 kernel?  Also
>>'nm vmlinux | grep printk' against the vmlinux for your 2.4.6 kernel?
>
>My 2.4.6 kernel can't boot because it panics when it goes to mount the root
>filesystem. An nm on the kernel returns 'File format not recognized'. It
>also returns this error when done on my 2.2.17 kernel, which runs just fine.

You do nm on vmlinux, not vmlinuz.  vmlinux is in the top level
directory of the kernel source tree after the build.

