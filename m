Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWK0S2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWK0S2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWK0S2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:28:40 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:3524 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S932068AbWK0S2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:28:39 -0500
X-Originating-Ip: 72.57.81.197
Date: Mon, 27 Nov 2006 13:25:34 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: what is the purpose of "CONFIG_DMA_IS_DMA32"?
Message-ID: <Pine.LNX.4.64.0611271314280.3419@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  perhaps a silly question, but:

$ grep -r "DMA_IS_DMA32" *
arch/ia64/defconfig:CONFIG_DMA_IS_DMA32=y
arch/ia64/configs/sim_defconfig:CONFIG_DMA_IS_DMA32=y
arch/ia64/configs/zx1_defconfig:CONFIG_DMA_IS_DMA32=y
arch/ia64/configs/tiger_defconfig:CONFIG_DMA_IS_DMA32=y
arch/ia64/configs/bigsur_defconfig:CONFIG_DMA_IS_DMA32=y
arch/ia64/configs/gensparse_defconfig:CONFIG_DMA_IS_DMA32=y
$

what is the purpose of a configuration symbol that is set but never
involved in a conditional check?

  i'm guessing that used to be a config setting in the ia64/Kconfig
file that has since vanished.

rday
