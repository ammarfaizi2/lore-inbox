Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284540AbRLMSZK>; Thu, 13 Dec 2001 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRLMSZA>; Thu, 13 Dec 2001 13:25:00 -0500
Received: from vitelus.com ([64.81.243.207]:13833 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S284540AbRLMSYp>;
	Thu, 13 Dec 2001 13:24:45 -0500
Date: Thu, 13 Dec 2001 10:24:23 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Cc: hfhsu@sis.com.tw, lcchang@sis.com.tw
Subject: Disappointing SiS900 performance - driver issue?
Message-ID: <20011213102423.B13809@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My new motherboard has an onboard SiS900 ethernet device. I was hoping
to free up a PCI slot by switching from my Intel EEPro100 to it. With
the Intel card I can quite easilly pull 11.5mb/s, but the SiS seems to
max out at 3.5mb/s or so. Is this the fault of the hardware or the
driver?

sis900.c: v1.08.01  9/25/2001
PCI: Assigned IRQ 11 for device 00:03.0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xcc00, IRQ 11, 00:d0:09:ea:ea:7e.
...
eth0: Media Link On 100mbps full-duplex 

