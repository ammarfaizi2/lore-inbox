Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286395AbSAEXbc>; Sat, 5 Jan 2002 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAEXbN>; Sat, 5 Jan 2002 18:31:13 -0500
Received: from 099.dsl6660135.nokia.surewest.net ([66.60.135.99]:20464 "HELO
	dragonglen.net") by vger.kernel.org with SMTP id <S286399AbSAEXbB>;
	Sat, 5 Jan 2002 18:31:01 -0500
Date: Sat, 5 Jan 2002 15:31:13 -0800 (PST)
From: Eric <eric@dragonglen.net>
X-X-Sender: <eric@fire.dragonglen.invalid>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 oops - ext2/ext3 fs corruption (?)
In-Reply-To: <3C375AC9.52462540@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201051528400.850-100000@fire.dragonglen.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Andrew Morton wrote:

> Eric wrote:
> > 
> > I seem to be having a reoccurring problem with my Red Hat 7.2 system
> > running kernel 2.4.17.  Four times now, I have seen the kernel generate an
> > oops.  After the oops, I find that one of file systems is no longer sane.
> > The effect that I see is a Segmentation Fault when things like ls or du
> > some directory (the directory is never the same).  Also, when the system
> > is going down for a reboot, it is unable to umount the file system.  The
> > umount command returns a "bad lseek" error.
> 
> Everything here points at failing hardware.  Probably memory errors.
> People say that memtest86 is good at detecting these things.  Another
> way to verify this is to move the same setup onto a different computer...

I ran memtest86 on the system and let it complete 4 passes before I 
stopped it.  It found no errors.  Unfortunately, I do not have another 
system available to test this on.  Are there any other diagnostics I can 
run to determine if this is truly a hardware problem?

Thanks,

Eric


