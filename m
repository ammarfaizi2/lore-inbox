Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUJ0KVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUJ0KVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUJ0KUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:20:51 -0400
Received: from math.ut.ee ([193.40.5.125]:49403 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262370AbUJ0KKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:10:19 -0400
Date: Wed, 27 Oct 2004 13:10:17 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Multiple serial port detection messages on PC
Message-ID: <Pine.GSO.4.44.0410271308570.19695-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.6.10-rc1+BK on a regular PC - from dmesg:

Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Probably a side result of the latest serial detection changes.

-- 
Meelis Roos (mroos@linux.ee)

