Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbTFSUCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbTFSUCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:02:06 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:39386 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S265921AbTFSUCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:02:05 -0400
Subject: Which driver for the 3C940 / 3C2000?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1056053787.2994.10.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 19 Jun 2003 22:16:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a bit confused about which driver a need for my onboard (Asus
P4C800 mobo) 3Com gigabit Ethernet controller. It should be a 3C940 but
sometimes it's called 3C2000. I found a driver at the asus site which
compiles and works with some kernel versions. Is there a proper (open
source) kernel driver for this chip? It seems that the tg3 driver
support some type of 3C940 but not mine.

lspci -n gives:

02:05.0 Class 0200: 10b7:1700 (rev 12)

This chip is also currently not defined in pci_ids.h (2.4 and 2.5)


Thanks,

Jurgen

