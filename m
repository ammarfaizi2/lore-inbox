Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSIEGAv>; Thu, 5 Sep 2002 02:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSIEGAv>; Thu, 5 Sep 2002 02:00:51 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:51974 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S317030AbSIEGAu>; Thu, 5 Sep 2002 02:00:50 -0400
Date: Thu, 5 Sep 2002 01:05:26 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.44.0209010014100.6399-100000@grace.speakeasy.net>
Message-ID: <Pine.LNX.4.44.0209050054580.20228-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Final update on this thread.

1. I fixed the busted DMA.  Full explanation of the bug and the
associated 2-line patch can be found in a separate message with subject
"[PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed".

2. The problem I saw with CDROM detection in 2.4.20-pre4-ac1 was PEBCAK.  
I had the cable backwards (host connector in the drive, master connector
in the controller).  2.4.19-ac4 doesn't seem to be sensitive to this.

3. Still no idea about the broken 80 pin cable detection - yes, I
double-checked the cable orientation :-)

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |



