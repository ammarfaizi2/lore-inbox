Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310337AbSCKSHW>; Mon, 11 Mar 2002 13:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310184AbSCKSHH>; Mon, 11 Mar 2002 13:07:07 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:4252 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S310344AbSCKSFw>; Mon, 11 Mar 2002 13:05:52 -0500
Date: Mon, 11 Mar 2002 18:05:36 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kUED-0001GB-00@the-village.bc.nu>
Message-ID: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:
> > Funny you should mention that point ... The "flagged taskfile code" is a
> > project to allow for NATIVE DFT support in Linux.  Nice screw job you did
> > to IBM.
> 
> Ok so whats native DFT and where does he (and I for that matter) read about
> it ?

DFT = Drive Fault Tolerance

It is an IBM utility which performs extensive diagnostics of a hard drive.
At present this is a DOS program which is used via a dos boot disk.

Have look at the IBM website where you can download this (you can get a dd
image of the boot floppy from there, too, if you don't have Windows).

The idea behind native DFT is to be able to perform drive diagnostics from
within the OS without rebooting with a DOS disk and tying up the system
for hours during the checks. The advantages of this combined with IDE/SCSI
hot swap are strikingly obvious...

The utility also returns a special fault code which in combination with
the ibm website allows you to return a faulty disk and obtain a
replacement very easily.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

