Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbRGLAMn>; Wed, 11 Jul 2001 20:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267380AbRGLAMd>; Wed, 11 Jul 2001 20:12:33 -0400
Received: from h24-76-51-210.vf.shawcable.net ([24.76.51.210]:7676 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S267379AbRGLAM1>; Wed, 11 Jul 2001 20:12:27 -0400
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: Switching Kernels without Rebooting?
Date: 11 Jul 2001 17:10:54 -0700
Organization: fireplug
Distribution: local
Message-ID: <9iipue$lo1$1@whiskey.enposte.net>
In-Reply-To: <994895240.21189@whiskey.enposte.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <994895240.21189@whiskey.enposte.net>,
Andreas Dilger <adilger@turbolinux.com> wrote:

>The best proposal I've heard so far was to use MOSIX to do live job
>migration between machines, and then upgrade the kernel like normal.
>In the end, it is the jobs that are running on the kernel, and not
>the kernel or the individual machine that are the most important.  One
>person pointed out that there is a single point of failure in the
>MOSIX "stub" machine, which doesn't help you in the end (how do you
>update the kernel there?).  If you can figure a way to enhance MOSIX
>to allow migrating the MOSIX "stub" processes to another machine, you
>will have solved your problem in a much easier way, IMHO.

If you then think of using VMWare or S/390 style methods of running multiple
copies of Linux on a single system you can now consider migrating processes
to a new kernel on the same system.


-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
