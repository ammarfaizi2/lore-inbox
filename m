Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbTFQIOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbTFQIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:14:09 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:25810 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id S264638AbTFQIOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:14:07 -0400
Date: Tue, 17 Jun 2003 10:27:44 +0200
From: CAMTP guest <camtp.guest@uni-mb.si>
Subject: CMD680 missing from 2.4.21?
To: linux-kernel@vger.kernel.org
Message-id: <16110.53504.547180.164358@proizd.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 7.14 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was CMD680 support forgotten in 2.4.21 or am I missing
something? In 2.4.19 and .20 I get:

CMD680: IDE controller on PCI bus 00 dev 58
CMD680: chipset revision 1
CMD680: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:pio, hdd:pio

in 2.4.21 it is not detected (same config). I have found
two related entries in ChangeLog:

ChangeLog-2.4.20:
Adrian Bunk <bunk@fs.tum.de>:
  o document that cmd64x.c supports the CMD649 and CMD680

ChangeLog-2.4.21:
Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o fix wrong clocking selection on CMD680/SII3112

-Igor Mozetic
