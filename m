Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSG2KUT>; Mon, 29 Jul 2002 06:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSG2KUT>; Mon, 29 Jul 2002 06:20:19 -0400
Received: from cibs9.sns.it ([192.167.206.29]:17682 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S314459AbSG2KUS>;
	Mon, 29 Jul 2002 06:20:18 -0400
Date: Mon, 29 Jul 2002 12:23:38 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: missing simbols in oss modules with 2.5.29
Message-ID: <Pine.LNX.4.43.0207291222500.3431-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.29; fi
depmod: *** Unresolved symbols in
/lib/modules/2.5.29/kernel/sound/oss/mpu401.o
depmod:         cli
depmod:         restore_flags
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.29/kernel/sound/oss/sound.o
depmod:         cli
depmod:         restore_flags
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.29/kernel/sound/oss/uart401.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in
/lib/modules/2.5.29/kernel/sound/oss/v_midi.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags


Hope this helps


