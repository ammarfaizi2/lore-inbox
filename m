Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317617AbSFIOip>; Sun, 9 Jun 2002 10:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317618AbSFIOio>; Sun, 9 Jun 2002 10:38:44 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:5105 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317616AbSFIOim>; Sun, 9 Jun 2002 10:38:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: r128.o unresolved symbol vmalloc_32
Date: Sun, 9 Jun 2002 16:38:34 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17H3pz-0006PB-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.5.21:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b /usr/src/linux-2.5.21/debian/tmp-image -r 2.5.21; fi
depmod: *** Unresolved symbols in /usr/src/linux-2.5.21/debian/tmp-image/lib/modules/2.5.21/kernel/drivers/char/drm/r128.o
depmod:         vmalloc_32
make[2]: *** [_modinst_post] Error 1
