Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWARUUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWARUUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWARUUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:20:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:43237 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030412AbWARUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:20:12 -0500
Date: Wed, 18 Jan 2006 21:20:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: menuconfig elements unaligned
Message-ID: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


in Drivers > Network > 10 or 100Mbit, this shows up:

 [*] EISA, VLB, PCI and on board controllers
 < >   AMD PCnet32 PCI support
 < >   AMD 8111 (new PCI lance) support
 < >   Adaptec Starfire/DuraLAN support
 < >   Broadcom 4400 ethernet support (EXPERIMENTAL)
 < >   Reverse Engineered nForce Ethernet support (EXPERIMENTAL)
 < > Digi Intl. RightSwitch SE-X support
 < > EtherExpressPro/100 support (eepro100, original Becker driver)
 < > Intel(R) PRO/100+ support

Deactivating EISA would suggest that Digi Intl. and everything below would
remain visible, but they do not. If someone got the time to, please fix it.
Thanks.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
