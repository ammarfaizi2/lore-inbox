Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281787AbSAEUDU>; Sat, 5 Jan 2002 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbSAEUDL>; Sat, 5 Jan 2002 15:03:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13072 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281504AbSAEUC6>; Sat, 5 Jan 2002 15:02:58 -0500
Message-ID: <3C375AC9.52462540@zip.com.au>
Date: Sat, 05 Jan 2002 11:58:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric <eric-linuxkernel@dragonglen.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 oops - ext2/ext3 fs corruption (?)
In-Reply-To: <Pine.LNX.4.33.0201051005190.5754-400000@fire.dragonglen.invalid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> 
> I seem to be having a reoccurring problem with my Red Hat 7.2 system
> running kernel 2.4.17.  Four times now, I have seen the kernel generate an
> oops.  After the oops, I find that one of file systems is no longer sane.
> The effect that I see is a Segmentation Fault when things like ls or du
> some directory (the directory is never the same).  Also, when the system
> is going down for a reboot, it is unable to umount the file system.  The
> umount command returns a "bad lseek" error.
> 
> The first time this happened, it resulted in catastrophic corruption of
> /usr and I had to reinstall.  At this time, /usr was an ext2 file system.
> When I reinstalled, I took the opportunity to reformat all the file
> systems, except /home, as ext3.
> 

Everything here points at failing hardware.  Probably memory errors.
People say that memtest86 is good at detecting these things.  Another
way to verify this is to move the same setup onto a different computer...

-
