Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbRBKRS2>; Sun, 11 Feb 2001 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129986AbRBKRST>; Sun, 11 Feb 2001 12:18:19 -0500
Received: from ns.linking.ee ([195.222.24.241]:59402 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S129936AbRBKRSK>;
	Sun, 11 Feb 2001 12:18:10 -0500
Date: Sun, 11 Feb 2001 19:17:43 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: Ookhoi <ookhoi@dds.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: aironet4500_card (2.4.1-ac8), The PCI BIOS has not enabled this
 device!
In-Reply-To: <20010209165837.K4103@ookhoi.dds.nl>
Message-ID: <Pine.LNX.4.21.0102111907520.21872-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, no time to test, neither I have cisco cards.

However, general notes:

	1. Aironet did (cisco may do) weird tricks on bus.
	2. insmod driver  -> leds go out, that may be  normal.
		ifconfig up should bring leds on.
	3. People who fail with both drivers (Bens and mine), have
	 had weird BIOS or BIOS settings in most of cases. 
	  IO conflict with bios configuration port (ICL  486 ),
	  old PCI BIOS (Intel Pentium 200Mhz board) , etc.


elmer.

	  
  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
