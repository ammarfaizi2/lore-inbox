Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSERNVZ>; Sat, 18 May 2002 09:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313114AbSERNVY>; Sat, 18 May 2002 09:21:24 -0400
Received: from p5087CAAA.dip.t-dialin.net ([80.135.202.170]:15121 "EHLO
	extern.linux-systeme.org") by vger.kernel.org with ESMTP
	id <S313060AbSERNVY>; Sat, 18 May 2002 09:21:24 -0400
Date: Sat, 18 May 2002 15:21:14 +0200 (MET DST)
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>, mcp@linux-systeme.de
Subject: Re: [PATCH] fixing supermount for > 2.4.19pre4
In-Reply-To: <200205181138.AWF97768@netmail.netcologne.de>
Message-ID: <Pine.LNX.3.96.1020518151559.8212A-100000@fps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> > your patch for supermount does not work. Now it's even not possible to list
> > the content via ls -lsa /mnt ... Mount hangs, no access is made, nothing.
> Is supermount compiled into kernel or as a module? What drive, what media did 
> you mount, what command did you issue? 

err, sorry for no details in my first mail :( ... I have headache and
thinking is not good at all ;(

Its a module, an IDE 50x CD-ROM Drive, Company: LION and i used a ISO9660
CD. I used the following command:

mount -t supermount -o dev=/dev/cdrom none /mnt

/dev/cdrom is a symlink to /dev/scd0, i use ide-scsi for CD-ROM access.

> and it works fine for me, patched against 2.4.19-pre8-jp12, and /dev/hdb is 
> an ISO 9660 CDROM in my DVD drive. No "stale NFS handles", clean mount and 
> unmount, and with "debug" option I can see it works as a charme.
hmm, strange :) ... i'm going to test it a little bit more ... Another
CD-Drive, other CD's ...

Kind regards,
	Marc

