Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbRAXRLO>; Wed, 24 Jan 2001 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131174AbRAXRLE>; Wed, 24 Jan 2001 12:11:04 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:1133 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131114AbRAXRK5>;
	Wed, 24 Jan 2001 12:10:57 -0500
From: "LA Walsh" <law@sgi.com>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: 2.4 IDE slowdown (misconfigure)
Date: Wed, 24 Jan 2001 09:06:22 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHEEDECKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.10.10101232332570.11572-100000@master.linux-ide.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have fixed the 66% slowdown -- disk speeds w/hdparm.  They are
reading in the same range.

For others -- my problem was that I upgraded from a 2.2.x config -- I
thought 'make xconfig' would add additional new params as needed as
'make config' does.  Guess I thought wrong.  

Thanks, Andre, for the quick help/fix!

-linda


> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linux-ide.org]
> Sent: Tuesday, January 23, 2001 11:40 PM
> To: Linda Walsh
> Subject: Forwarded mail....
> 
> 
> 
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> was
> CONFIG_BLK_DEV_IDEDMA=y
> 
> Added a few missing........
> 
> 
> Andre Hedrick
> Linux ATA Development
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
