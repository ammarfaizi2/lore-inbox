Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWGKMnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWGKMnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGKMnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:43:40 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:39880 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751252AbWGKMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:43:39 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] AVR32 update
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 11 Jul 2006 14:43:15 +0200
Message-Id: <11526218021728-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

The following patchset fixes a few issues found when trying out
different configuration settings on AVR32. It also adds a reasonable
default configuration for the AT32STK1002 board to make it easier
for people to build a working kernel for themselves.

I should also mention that I may be less responsive the next two
weeks as I leave for vacation, but as long as you Cc linux-kernel,
I'll pick it up (I won't be able to respond to stuff sent to
hskinnemoen@atmel.com as our VPN setup is completely broken.)

Thanks,
Haavard

---

 arch/avr32/Kconfig                       |    8
 arch/avr32/Kconfig.debug                 |    4
 arch/avr32/configs/at32stk1002_defconfig |  754 ++++++++++++++++++++++++++++++
 arch/avr32/kernel/avr32_ksyms.c          |    7
 include/asm-avr32/atomic.h               |   10
 include/asm-avr32/bitops.h               |   20 -
 include/asm-avr32/irqflags.h             |   68 +++
 include/asm-avr32/system.h               |   32 -
 lib/Kconfig.debug                        |    4
 9 files changed, 856 insertions(+), 51 deletions(-)
