Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbTHaTJc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 15:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbTHaTJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 15:09:32 -0400
Received: from tdl.com ([206.180.224.3]:5775 "EHLO tdl.com")
	by vger.kernel.org with ESMTP id S261636AbTHaTJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 15:09:31 -0400
Date: Sun, 31 Aug 2003 12:09:30 -0700
From: Randall Craig <randall@tdl.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre2 modular ide-core broken
Message-ID: <20030831190930.GA3290@tdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depmod reports the following unresolved symbols:

depmod: *** Unresolved symbols in
/lib/modules/2.4.23-pre2-4GB-SMP/kernel/drivers/ide/ide-core.o
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives

Thus ide can't be modular
