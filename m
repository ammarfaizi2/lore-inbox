Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUIUKel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUIUKel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 06:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUIUKel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 06:34:41 -0400
Received: from smtp.Uni-Siegen.DE ([141.99.1.31]:21007 "HELO
	smtp2.uni-siegen.de") by vger.kernel.org with SMTP id S267558AbUIUKej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 06:34:39 -0400
Message-ID: <415003AA.9020203@informatik.uni-siegen.de>
Date: Tue, 21 Sep 2004 12:34:18 +0200
From: Thomas Unger <unger@informatik.uni-siegen.de>
Organization: University of Siegen FB12-PS
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: keylargo PCI USB controller nor enabled on G4 xserve
References: <41485359.80602@informatik.uni-siegen.de> <1095384315.2214.21.camel@gaston>
In-Reply-To: <1095384315.2214.21.camel@gaston>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Benjamin Herrenschmidt wrote:
> Can you try that workaround (quite ugly until I figure out what's
> really going on in there) and let me know if it makes any difference ?
> .
> 

thank you!
your patches works indeed, no more duplicate entries and USB
works fine, too. here comes the current pci list:

0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 AGP
0000:00:10.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]
0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 PCI
0001:10:0d.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0001:10:11.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
0001:10:15.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0001:10:1b.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)
0001:11:07.0 ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
0001:11:08.0 USB Controller: Apple Computer Inc. KeyLargo USB
0001:11:09.0 USB Controller: Apple Computer Inc. KeyLargo USB
0001:12:02.0 Ethernet controller: Apple Computer Inc. Tigon3 Gigabit
Ethernet NIC (BCM5701) (rev 15)
0001:12:03.0 Ethernet controller: National Semiconductor Corporation
DP83820 10/100/1000 Ethernet Controller
0002:22:0b.0 Host bridge: Apple Computer Inc. UniNorth 2 Internal PCI
0002:22:0d.0 ff00: Apple Computer Inc. UniNorth 2 ATA/100
0002:22:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth 2
FireWire (rev 01)
0002:22:0f.0 Ethernet controller: Apple Computer Inc. UniNorth 2 GMAC
(Sun GEM)

	Greetings,
		Thomas Unger
