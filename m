Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSBXCKb>; Sat, 23 Feb 2002 21:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289210AbSBXCKM>; Sat, 23 Feb 2002 21:10:12 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:11158 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S289191AbSBXCKB>; Sat, 23 Feb 2002 21:10:01 -0500
Date: Sat, 23 Feb 2002 21:09:58 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
Subject: Re: floppy in 2.4.17
In-Reply-To: <3C77CD19.2040501@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0202232108370.11437-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Pierre ,  pnp is completely disabled in my kernel .
		Hth ,  JimL

# grep -i pnp /usr/src/linux/.config

# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_IP_PNP is not set
# CONFIG_BLK_DEV_ISAPNP is not set


On Sat, 23 Feb 2002, Pierre Rousselet wrote:

> Have you tried booting with "pnpbios=no-res" ?
>
>
> Mr. James W. Laferriere wrote:
> > 	Hello All ,  More info ...  Hth ,  JimL
> >
> > On Sat, 23 Feb 2002, Mr. James W. Laferriere wrote:
> >
> >>	Hello J.A. , Nice name .  I have verified that the floppy drive
> >>	under 2.4.18-pre3 is in the same shape . Hth ,  JimL
> >>
> >
> >># fdformat /dev/fd0u1440		,  Hmmm ,  Move little tab .
> >>/dev/fd0u1440: Read-only file system
> >># fdformat /dev/fd0u1440		,  Hmmm ......
> >>/dev/fd0u1440: Read-only file system
> >># tar -ztvf /dev/fd0			,  Hmmm ,  J.A.'s right .
> >>(hang ..wait several minutes..)^C
> >>tar (grandchild): Read error on /dev/fd0: Input/output error
> >>tar (grandchild): At beginning of tape, quitting now
> >>tar (grandchild): Error is not recoverable: exiting now
> >>
> >>gzip: stdin: unexpected end of file
> >>tar: Child returned status 1
> >>tar: Error exit delayed from previous errors
> >>
> >
> > VFS: Disk change detected on device fd(2,28)
> > VFS: Disk change detected on device fd(2,28)
> > VFS: Disk change detected on device fd(2,28)
> > VFS: Disk change detected on device fd(2,28)
> > VFS: Disk change detected on device fd(2,0)
> > end_request: I/O error, dev 02:00 (floppy), sector 0
> > end_request: I/O error, dev 02:00 (floppy), sector 0
> > end_request: I/O error, dev 02:00 (floppy), sector 2
> > end_request: I/O error, dev 02:00 (floppy), sector 4
> > end_request: I/O error, dev 02:00 (floppy), sector 6
> >
> >
> >
> >>On Sat, 23 Feb 2002, J.A. Magallon wrote:
> >>
> >>
> >>>Hi.
> >>>
> >>>I am getting problems with floppy drive in 2.4.17.
> >>>All started with floppy not working in 18-rc4, went back to 17
> >>>and still does not work. Just plain 2.4.17, no patching.
> >>>
> >>>mkfs -t ext2 /dev/fd0 just hangs forever.
> >>>
> >>>mkfs -v -t ext2 /dev/fd0 gives:
> >>>
> >>>mke2fs 1.26 (3-Feb-2002)
> >>>mkfs.ext2: bad blocks count - /dev/fd0
> >>>
> >>>Hardware:
> >>>
> >>>Floppy drive(s): fd0 is 1.44M
> >>>FDC 0 is a post-1991 82077
> >>>ide-floppy driver 0.97.sv
> >>>
> >>>???
> >>>
> >>>TIA
> >>>
>
>
>
>
> Pierre
> --
> ------------------------------------------------
>   Pierre Rousselet <pierre.rousselet@wanadoo.fr>
> ------------------------------------------------
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

