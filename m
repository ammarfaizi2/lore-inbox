Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSG2KuP>; Mon, 29 Jul 2002 06:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSG2KuP>; Mon, 29 Jul 2002 06:50:15 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:19840 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S315168AbSG2KuO>;
	Mon, 29 Jul 2002 06:50:14 -0400
Date: Mon, 29 Jul 2002 13:53:34 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: link errors in 2.5.29+bk
Message-ID: <Pine.GSO.4.43.0207291351390.24473-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to be connected to the recent migration thread changes:

init/init.o: In function `do_pre_smp_initcalls':
init/init.o(.text+0x59): undefined reference to `migration_init'

aic7xxx_old has yet to be converted to cli removal:

drivers/built-in.o: In function `aic7xxx_handle_seqint':
drivers/built-in.o(.text+0x2d2c4): undefined reference to `sti'
drivers/built-in.o: In function `aic7xxx_isr':
drivers/built-in.o(.text+0x320b4): undefined reference to `sti'


-- 
Meelis Roos (mroos@linux.ee)

