Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRBABbC>; Wed, 31 Jan 2001 20:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRBABay>; Wed, 31 Jan 2001 20:30:54 -0500
Received: from mtiwmhc27.worldnet.att.net ([204.127.131.52]:54744 "EHLO
	mtiwmhc27.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S129498AbRBABag>; Wed, 31 Jan 2001 20:30:36 -0500
Date: Wed, 31 Jan 2001 20:30:28 -0500
From: khromy <khromy@khromy.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 unresolved reference
Message-ID: <20010131203028.A58551@khromy.lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.1 - make bzImage modules

CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set

drivers/ide/idedriver.o: In function `pci_init_pdc202xx':
drivers/ide/idedriver.o(.text.init+0x1ac4): undefined reference to `pdc202xx_display_info'
make: *** [vmlinux] Error 1
-- 
L1:	khromy		;khromy(at)khromy.lnuxlab.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
