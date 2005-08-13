Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVHPPr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVHPPr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVHPPr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:47:27 -0400
Received: from AReims-151-1-72-193.w83-198.abo.wanadoo.fr ([83.198.94.193]:29453
	"EHLO arda.LT-P.net") by vger.kernel.org with ESMTP
	id S1030193AbVHPPr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:47:26 -0400
Date: Sun, 14 Aug 2005 00:54:30 +0200
From: LT-P <LT-P@LT-P.net>
To: Horms <horms@debian.org>
Cc: 321442@bugs.debian.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc
 (drivers/ide/ppc/pmac.c)
Message-ID: <20050814005430.2e26e627@arda.LT-P.net>
In-Reply-To: <20050808085703.GE18551@verge.net.au>
References: <E1E13vT-0008G7-R1@arda.LT-P.net>
	<20050808085703.GE18551@verge.net.au>
Organization: Banquise
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 08 aoû 2005 17:57:04 CEST, Horms <horms@debian.org> a écrit:

> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves your
> problem. If it does, then the following patch should fix Kconfig
> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMAC
> to be enabled. It should patch cleanly against Debian's 2.6.8 and
> Linus' current Git tree.
It seems to solve the problem, thanks.
Sometimes, I feel like I am the only person in the world to compile the kernel on
powerpc... :)

LT-P

-- 
Seals are cute, kiss them
