Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131251AbRACXKI>; Wed, 3 Jan 2001 18:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRACXJ6>; Wed, 3 Jan 2001 18:09:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30987 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131251AbRACXJs>; Wed, 3 Jan 2001 18:09:48 -0500
Subject: Re: Yet more benchmarks for 2.4.0-prerelease and -ac[4,5]
To: scole@lanl.gov
Date: Wed, 3 Jan 2001 23:11:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010315250600.01807@spc.esa.lanl.gov> from "Steven Cole" at Jan 03, 2001 03:25:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Dx4X-0004nO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> recent kernels.  It looks like there may be a slight drop
> in performance for -ac5.  For -ac4 and -ac5, the throughput

-ac5 touches stuff which would have performance effects. That would be 
reasonable to suspect.

	-	Rik's partial page changes
	-	A couple of other minor vm touches

If it is relaed to those then you should see the same loss of speed on the
testing/prerelease file on ftp.kernel.org. 

> dropped on run #3.  That's probably just a fluke.  I'll repeat
> these runs later when I get a chance.

4 doesnt change anything except for FATfs and writing raw off end of disks
so for now lets assume fluke

Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
