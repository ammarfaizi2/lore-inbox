Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286253AbSAAMlm>; Tue, 1 Jan 2002 07:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSAAMlc>; Tue, 1 Jan 2002 07:41:32 -0500
Received: from ns.suse.de ([213.95.15.193]:47625 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286253AbSAAMl2>;
	Tue, 1 Jan 2002 07:41:28 -0500
Date: Tue, 1 Jan 2002 13:41:26 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Danny ter Haar <dth@trinity.hoho.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-dj10
In-Reply-To: <E16LKoz-0004bS-00@trinity.hoho.nl>
Message-ID: <Pine.LNX.4.33.0201011339240.23436-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, Danny ter Haar wrote:

> drivers/md/mddev.o: In function `lvm_user_bmap':
> drivers/md/mddev.o(.text+0xf13): undefined reference to `lvm_get_blksize'
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/archive/usr.src/linux-2.5.1-dj10'
> make: *** [stamp-build] Error 2
> ws2:/usr/src/linux-2.5.1-dj10#
>
> My system relies on LVM and reiserfs.

Yup, someone needs to do bio surgery on lvm.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

