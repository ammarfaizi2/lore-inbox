Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273414AbRIWL6l>; Sun, 23 Sep 2001 07:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273419AbRIWL6X>; Sun, 23 Sep 2001 07:58:23 -0400
Received: from duba03h03-0.dplanet.ch ([212.35.36.23]:48907 "EHLO
	duba03h03-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S273414AbRIWL6M>; Sun, 23 Sep 2001 07:58:12 -0400
Message-ID: <3BADE8C9.A8A587CE@dplanet.ch>
Date: Sun, 23 Sep 2001 15:51:05 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10-pre15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre15: link error, drm <-> mtrr
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        /home/src/linux/arch/i386/lib/lib.a /home/src/linux/lib/lib.a
/home/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/drm/drm.o: In function `tdfx_addmap':
drivers/char/drm/drm.o(.text+0x4d3): undefined reference to `mtrr_add'
drivers/char/drm/drm.o: In function `tdfx_rmmap':
drivers/char/drm/drm.o(.text+0x784): undefined reference to `mtrr_del'
drivers/char/drm/drm.o: In function `tdfx_takedown':
drivers/char/drm/drm.o(.text+0x1647): undefined reference to `mtrr_del'
drivers/char/drm/drm.o: In function `tdfx_vm_shm_close':
drivers/char/drm/drm.o(.text+0x4700): undefined reference to `mtrr_del'
make: *** [vmlinux] Error 1


Time to modify Config.in ?


	giacomo
