Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTKKLEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 06:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTKKLEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 06:04:41 -0500
Received: from catv-50620dee.bp13catv.broadband.hu ([80.98.13.238]:53263 "EHLO
	guard.localnet") by vger.kernel.org with ESMTP id S263378AbTKKLEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 06:04:40 -0500
Subject: [BUG] Modular ide in 2.4.23-rc1 is still broken
From: Attila BODY <compi@freemail.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1068548667.19133.3.camel@smiley.localnet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 Nov 2003 12:04:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It compiles fine, but depmod finds unresolved symbols in ide-core.o:

depmod: *** Unresolved symbols in
/home/compi/linux/lib/modules/2.4.23-rc1/kernel/drivers/ide/ide-core.o
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives


