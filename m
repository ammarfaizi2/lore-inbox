Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293508AbSCKWGW>; Mon, 11 Mar 2002 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSCKWGG>; Mon, 11 Mar 2002 17:06:06 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:1682 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S293362AbSCKWFp>; Mon, 11 Mar 2002 17:05:45 -0500
Message-Id: <5.1.0.14.2.20020311220147.05a9e3b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 11 Mar 2002 22:06:19 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] 2.5.6 IDE 19
Cc: aia21@cus.cam.ac.uk (Anton Altaparmakov),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        andre@linuxdiskcert.org (Andre Hedrick),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <E16kVdS-0001U0-00@the-village.bc.nu>
In-Reply-To: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:39 11/03/02, Alan Cox wrote:
> > The idea behind native DFT is to be able to perform drive diagnostics from
> > within the OS without rebooting with a DOS disk and tying up the system
> > for hours during the checks. The advantages of this combined with IDE/SCSI
> > hot swap are strikingly obvious...
>
>So providing we have a properly generic "issue IDE command from user space"
>do we need any more kernel magic for this ?

No, AFAIK.

You need to be able to tell the kernel not to touch the drive during the 
testing or a lot of fun things might happen... (I would assume.)

Oh and I was brain dead when I wrote what DFT stands for. Sorry. It is of 
course DFT = Drive Fitness Test and the DFT utility boot floppy I mentioned 
can be downloaded from: http://www.storage.ibm.com/hdd/support/download.htm

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

