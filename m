Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbTDUAwt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 20:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTDUAwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 20:52:49 -0400
Received: from ridcully.bzimage.de ([213.146.113.136]:60032 "EHLO
	ridcully.bzimage.de") by vger.kernel.org with ESMTP id S263746AbTDUAwt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 20:52:49 -0400
Date: Mon, 21 Apr 2003 03:04:49 +0200
From: Norbert Tretkowski <tretkowski@bzimage.de>
To: linux-kernel@vger.kernel.org
Subject: tgafb does not compile in 2.5.68
Message-ID: <20030421010449.GA3962@rollcage.bzimage.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Mail-Copies-To: never
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,drivers/video/.tgafb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev56 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tgafb -DKBUILD_MODNAME=tgafb -c -o drivers/video/tgafb.o drivers/video/tgafb.c
drivers/video/tgafb.c: In function `tgafb_set_par':
drivers/video/tgafb.c:233: `color_table' undeclared (first use in this function)
drivers/video/tgafb.c:233: (Each undeclared identifier is reported only once
drivers/video/tgafb.c:233: for each function it appears in.)
drivers/video/tgafb.c:234: `default_red' undeclared (first use in this function)
drivers/video/tgafb.c:236: `default_grn' undeclared (first use in this function)
drivers/video/tgafb.c:238: `default_blu' undeclared (first use in this function)
make[3]: *** [drivers/video/tgafb.o] Error 1
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make: *** [vmlinux] Error 2

gcc version 3.2.3 20030415 (Debian prerelease) on alpha
