Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbUCNNZC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 08:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbUCNNZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 08:25:02 -0500
Received: from lech.pse.pl ([194.92.3.7]:52145 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id S263361AbUCNNY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 08:24:58 -0500
Date: Sun, 14 Mar 2004 14:24:56 +0100
From: Lech Szychowski <lech.szychowski@pse.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: bcm5700  driver at 100Mbit? tg3 doesn't do 100Mbit - 2.6.4-mm1
Message-ID: <20040314132456.GA14249@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4053F511.1070607@blueyonder.co.uk> <20040314123014.GA8839@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314123014.GA8839@merlin.emma.line.org>
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > tg3.ko loads, network starts up. Can't connect to 100Mbit network 
> > switch. The bcm5700 driver in ths SuSE kraxel 2.6.3 kernel works. The 
> > tg3  is supposed to be a replacement for bcm5700 I believe.

Works for me (Dell Latitude D600), both for "NIC to switch"...

===
Mar 12 16:20:37 y kernel: Linux version 2.6.4-mm1 (lech7@y) (gcc version 3.3.3) #1 Thu Mar 11 14:16:54 CET 2004
[...]
Mar 12 16:20:37 y kernel: eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0d:56:7b:d8:9d
[...]
Mar 12 16:20:39 y kernel: tg3: eth0: Link is up at 100 Mbps, half duplex.
Mar 12 16:20:39 y kernel: tg3: eth0: Flow control is off for TX and off for RX.
===

...and "NIC to NIC" mode:

===
Mar 14 03:43:08 y kernel: Linux version 2.6.4-mm1 (lech7@y) (gcc version 3.3.3) #1 Thu Mar 11 14:16:54 CET 2004
[...]
Mar 14 03:43:08 y kernel: eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0d:56:7b:d8:9d
[...]
Mar 14 03:43:10 y kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Mar 14 03:43:10 y kernel: tg3: eth0: Flow control is off for TX and off for RX.
===

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
