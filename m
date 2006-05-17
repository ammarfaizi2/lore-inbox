Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWEQPQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWEQPQi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWEQPQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:16:38 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:19369 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1750808AbWEQPQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:16:37 -0400
To: linux-kernel@vger.kernel.org
CC: user-mode-linux-devel@lists.sourceforge.net, hpa@zytor.com, akpm@osdl.org
Subject: klibc build broken on UML
Message-Id: <E1FgNkr-00024G-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 May 2006 17:16:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent because prev. post bounced on hpa and akpm due to mail problems here]

I get this on 2.6.17-rc4-mm1:

  CHK     include/linux/compile.h
/usr/src/quilt/linux/scripts/Kbuild.klibc:60: /usr/src/quilt/linux/usr/klibc/arch/um/MCONFIG: No such file or directory
usr/klibc/Kbuild:71: usr/klibc/arch/um/Makefile.inc: No such file or directory
make[2]: *** No rule to make target `usr/klibc/arch/um/Makefile.inc'.  Stop.
make[1]: *** [_usr_klibc] Error 2
make: *** [usr] Error 2

Miklos
