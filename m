Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRAPWRH>; Tue, 16 Jan 2001 17:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132558AbRAPWQ5>; Tue, 16 Jan 2001 17:16:57 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:11077 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S132546AbRAPWQp>; Tue, 16 Jan 2001 17:16:45 -0500
Message-Id: <200101161948.f0GJmb602257@possum.os2.ami.com.au>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order? 
In-Reply-To: Your message of "Tue, 16 Jan 2001 11:31:25 EST."
             <1355693A51C0D211B55A00105ACCFE64E9518F@ATL_MS1> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Jan 2001 03:48:37 +0800
From: John Summerfield <summer@Os2.aMi.coM.AU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Venkateshr@ami.com said:
> Like the ext2 labels? (man e2label)
> 	[Venkatesh Ramamurthy]  This re-ordering of the scsi drives should be
> done by SCSI ML , so is incorporating ext2 fs data structure knowledge
> on the SCSI ML a good idea?.  

You'd better not care what the drives ae called - it will all change with 
devfs.

filesystem labels are to identify the filesystems so you can mount the right 
ones in the right places. Even if the device names change.




-- 
Cheers
John Summerfield
http://www2.ami.com.au/ for OS/2 & linux information.
Configuration, networking, combined IBM ftpsites index.

Note: mail delivered to me is deemed to be intended for me, for my disposition.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
