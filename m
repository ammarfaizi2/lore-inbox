Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269090AbRG3Xpb>; Mon, 30 Jul 2001 19:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269093AbRG3XpV>; Mon, 30 Jul 2001 19:45:21 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:19474 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269089AbRG3XpJ>; Mon, 30 Jul 2001 19:45:09 -0400
Date: Mon, 30 Jul 2001 19:45:16 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: pci_ids.h and pci.ids
Message-ID: <Pine.LNX.4.33.0107301931060.13779-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

All this talk of serial ports and PCI cards got me to do a 'lspci' on my
machine with a Lava DSerial-PCI. The entry shown for it was 'Serial
controller: Lava Computer mfg Inc: Unknown device 0100'. The first and second
parts looked fine, but the third part looked wrong. I did some poking around
and found that it is in <linux/pci_ids.h> but not in pci.ids. The file pci.ids
is part of pciutils, of which the latest version (2.1.8) is from May 20, 2000.

So then the question is: Would is be practical/possible to generate pci.ids
from pci_ids.h? I realize that there isn't currently enough information in it,
but I'm just fishing for ideas right now.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>



