Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbUAEWYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUAEWXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:23:21 -0500
Received: from cmsrelay01.mx.net ([165.212.11.110]:7321 "HELO
	cmsrelay01.mx.net") by vger.kernel.org with SMTP id S265958AbUAEWWM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:22:12 -0500
X-USANET-Auth: 165.212.8.2     AUTO bradtilley@usa.net uwdvg002.cms.usa.net
Date: Mon, 05 Jan 2004 17:22:06 -0500
From: Brad Tilley <bradtilley@usa.net>
To: <linux-kernel@vger.kernel.org>
Subject: broadcom bcm5700 patch for 2.4.24
X-Mailer: USANET web-mailer (CM.0402.7.03)
Mime-Version: 1.0
Message-ID: <940iaewwg7440S02.1073341326@uwdvg002.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Broadcom has a patch for 2.4.22, not 23 or 24. While trying to patch a vanilla
2.4.24 using the 22 patch, I get one hunk failure. I know this isn't a kernel
issue. Could someone (more influentianl than me) encourage Broadcom to release
up-to-date patches? Or, if someone has a patch that works with 2.4.24, would
you email it to me?

Here's the output from the 2.4.22 patch:

patch -p1 -d /home/rbt/src/linux-2.4.24 < bcm5700-7.1.9-2.4.22.patch
patching file Documentation/Configure.help
Hunk #1 succeeded at 11883 with fuzz 2 (offset 637 lines).
patching file drivers/net/bcm/5701rls.c
patching file drivers/net/bcm/5701rls.h
patching file drivers/net/bcm/autoneg.c
patching file drivers/net/bcm/autoneg.h
patching file drivers/net/bcm/b57proc.c
patching file drivers/net/bcm/b57um.c
patching file drivers/net/bcm/bits.h
patching file drivers/net/bcm/fw_lso05.h
patching file drivers/net/bcm/fw_stkoffld.h
patching file drivers/net/bcm/lm.h
patching file drivers/net/bcm/Makefile
patching file drivers/net/bcm/mm.h
patching file drivers/net/bcm/nicext.h
patching file drivers/net/bcm/queue.h
patching file drivers/net/bcm/tcp_seg.c
patching file drivers/net/bcm/tigon3.c
patching file drivers/net/bcm/tigon3.h
patching file drivers/net/Config.in
Hunk #1 FAILED at 269.
1 out of 1 hunk FAILED -- saving rejects to file drivers/net/Config.in.rej
patching file drivers/net/Makefile
Hunk #1 succeeded at 67 with fuzz 1 (offset 36 lines).
Hunk #2 FAILED at 93.
1 out of 2 hunks FAILED -- saving rejects to file drivers/net/Makefile.rej

Please CC me as I'm off list.

Thanks,
Brad


