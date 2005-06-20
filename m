Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVFTJPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVFTJPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 05:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFTJPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 05:15:45 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:4514 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261296AbVFTJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 05:15:40 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-mm1 breaks Toshiba laptop yenta cardbus
Date: Mon, 20 Jun 2005 19:15:34 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <s32db1toatpgar8nun4m5rtqq97hkbk2ab@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
yenta 0000:00:0b.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:00:0b.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:00:0b.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:00:0b.0: no resource of type 200 available, trying to continue...
yenta 0000:00:0b.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:00:0b.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:00:0b.0: no resource of type 100 available, trying to continue...
yenta 0000:00:0b.0: Preassigned resource 3 busy, reconfiguring...
yenta 0000:00:0b.0: Preassigned resource 3 busy, reconfiguring...
yenta 0000:00:0b.0: no resource of type 100 available, trying to continue...
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000020

2.6.12 okay

See:
  http://scatter.mine.nu/test/linux-2.6/tosh/
for config, dmesg, cpu, mem, ioports, etc

--Grant.

