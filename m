Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266206AbUFJGMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUFJGMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUFJGMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:12:13 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:57568 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266207AbUFJGL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:11:59 -0400
Subject: hdc (cdrom) irq timeout after awaking from sleep on powerbook
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@KERNEL.CRASHING.ORG>
Content-Type: text/plain
Message-Id: <1086847896.24317.41.camel@localhost>
Mime-Version: 1.0
Date: Thu, 10 Jun 2004 08:11:37 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

When I insert + mount a cdrom and then put this powerbook to sleep mode,
I keep getting these messages in the kernel log when the machine wakes
up. However I can still access the cdrom on its mount point as if
everything was ok... but is it ?

This is kernel 2.6.7-rc2 on powerbook g4 1Ghz.

Please comment,
Regards,
Soeren.

VFS: busy inodes on changed media.
hdc: irq timeout: status=0xc0 { Busy }
hdc: irq timeout: error=0xc0LastFailedSense 0x0c 
hdc: DMA disabled
hdc: ATAPI reset complete
VFS: busy inodes on changed media.

