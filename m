Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTIJOXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTIJOXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:23:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57362 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264330AbTIJOXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:23:33 -0400
Date: Wed, 10 Sep 2003 10:14:37 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5-mm1 aha152x **still** doesn't work (fwd)
Message-ID: <Pine.LNX.3.96.1030910101202.21238F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oddball:root> modprobe aha152x aha152x=0x340,9,7,1,1,1
SCSI subsystem initialized
aha152x: invalid module params io=0x340, irq=8,scsiid=7,reconnect=1,parity=1,sync=1,delay=1000,exttrans=0
FATAL: Error inserting aha152x 
(/lib/modules/2.6.0-test5-mm1/kernel/drivers/scsi/aha152x.ko): No such 
device


It happily looks at the "9" in the init string and says "irq=8" doesn't 
work. Works with the 2.4.18 kernel from RH7.3, so ??? The IRQ jumpers are 
soldered on the board.

Clearly if I had the option of using another board I would, that's not
going to happen for various reasons (administrative and technical).

