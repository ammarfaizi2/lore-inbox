Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWEQNEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWEQNEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWEQNEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:04:41 -0400
Received: from 245-051.dyn-fa.pool.ew.hu ([193.226.245.51]:32944 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932250AbWEQNEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:04:40 -0400
To: linux-kernel@vger.kernel.org
CC: user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com, akpm@osdl.org
Subject: klibc build broken on UML
Message-Id: <E1FgLhI-0001eK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 May 2006 15:04:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this on 2.6.17-rc4-mm1:

  CHK     include/linux/compile.h
/usr/src/quilt/linux/scripts/Kbuild.klibc:60: /usr/src/quilt/linux/usr/klibc/arch/um/MCONFIG: No such file or directory
usr/klibc/Kbuild:71: usr/klibc/arch/um/Makefile.inc: No such file or directory
make[2]: *** No rule to make target `usr/klibc/arch/um/Makefile.inc'.  Stop.
make[1]: *** [_usr_klibc] Error 2
make: *** [usr] Error 2

Miklos
