Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUCVRrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCVRrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:47:24 -0500
Received: from math.ut.ee ([193.40.5.125]:3569 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261317AbUCVRrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:47:23 -0500
Date: Mon, 22 Mar 2004 19:47:21 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: PnPBIOS: Unknown tag '0x82'
Message-ID: <Pine.GSO.4.44.0403221937330.18189-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the beginning of its existence, the pnpbios driver talks about
unknown tag '0x82' on one of my computers. The computer has Intel
D815EEA2 mainboard, BIOS has been updated quite recently. I added the
tag dump to printout and here it is:

PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20

This 0x82 0x12 0x00 and then 'Intel Firmware'.

Anything to worry about? Are the next tags still correctly parsed? The
full dmesg is now

PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f2480
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x1d2a, dseg 0xf0000
pnp: 00:09: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:09: ioport range 0xcf8-0xcff could not be reserved
PnPBIOS: Unknown tag '0x82', length '18': 82 12 00 49 6e 74 65 6c 20 46 69 72 6d 77 61 72 65 20 .
pnp: 00:0b: ioport range 0x800-0x87f has been reserved
PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver

-- 
Meelis Roos (mroos@linux.ee)


