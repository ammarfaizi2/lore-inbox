Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293150AbSBWQEZ>; Sat, 23 Feb 2002 11:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSBWQEQ>; Sat, 23 Feb 2002 11:04:16 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:37013 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S293150AbSBWQEF>; Sat, 23 Feb 2002 11:04:05 -0500
Date: Sat, 23 Feb 2002 11:04:04 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
cc: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: floppy in 2.4.17
In-Reply-To: <Pine.LNX.4.44.0202231054460.11337-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.44.0202231100230.11337-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  More info ...  Hth ,  JimL

On Sat, 23 Feb 2002, Mr. James W. Laferriere wrote:
> 	Hello J.A. , Nice name .  I have verified that the floppy drive
> 	under 2.4.18-pre3 is in the same shape . Hth ,  JimL

> # fdformat /dev/fd0u1440		,  Hmmm ,  Move little tab .
> /dev/fd0u1440: Read-only file system
> # fdformat /dev/fd0u1440		,  Hmmm ......
> /dev/fd0u1440: Read-only file system
> # tar -ztvf /dev/fd0			,  Hmmm ,  J.A.'s right .
> (hang ..wait several minutes..)^C
> tar (grandchild): Read error on /dev/fd0: Input/output error
> tar (grandchild): At beginning of tape, quitting now
> tar (grandchild): Error is not recoverable: exiting now
>
> gzip: stdin: unexpected end of file
> tar: Child returned status 1
> tar: Error exit delayed from previous errors

VFS: Disk change detected on device fd(2,28)
VFS: Disk change detected on device fd(2,28)
VFS: Disk change detected on device fd(2,28)
VFS: Disk change detected on device fd(2,28)
VFS: Disk change detected on device fd(2,0)
end_request: I/O error, dev 02:00 (floppy), sector 0
end_request: I/O error, dev 02:00 (floppy), sector 0
end_request: I/O error, dev 02:00 (floppy), sector 2
end_request: I/O error, dev 02:00 (floppy), sector 4
end_request: I/O error, dev 02:00 (floppy), sector 6


> On Sat, 23 Feb 2002, J.A. Magallon wrote:
>
> > Hi.
> >
> > I am getting problems with floppy drive in 2.4.17.
> > All started with floppy not working in 18-rc4, went back to 17
> > and still does not work. Just plain 2.4.17, no patching.
> >
> > mkfs -t ext2 /dev/fd0 just hangs forever.
> >
> > mkfs -v -t ext2 /dev/fd0 gives:
> >
> > mke2fs 1.26 (3-Feb-2002)
> > mkfs.ext2: bad blocks count - /dev/fd0
> >
> > Hardware:
> >
> > Floppy drive(s): fd0 is 1.44M
> > FDC 0 is a post-1991 82077
> > ide-floppy driver 0.97.sv
> >
> > ???
> >
> > TIA

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

