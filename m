Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318354AbSGYGa2>; Thu, 25 Jul 2002 02:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318358AbSGYGa2>; Thu, 25 Jul 2002 02:30:28 -0400
Received: from [210.19.28.11] ([210.19.28.11]:4224 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S318354AbSGYGa1> convert rfc822-to-8bit; Thu, 25 Jul 2002 02:30:27 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Corporal Pisang <corporal_pisang@counter-strike.com.my>
Organization: Counter-Strike.com.my
To: linux-kernel@vger.kernel.org
Subject: 2.5.28 make modules_install error (sound/oss/*.o , net/irda/irda.o)
Date: Thu, 25 Jul 2002 14:39:56 +0800
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207251439.56867.corporal_pisang@counter-strike.com.my>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

#make modules_install
---snip---
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.28; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.28/kernel/net/irda/irda.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/ad1848.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/mpu401.o
depmod:         cli
depmod:         restore_flags
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/opl3sa.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/opl3sa2.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in /lib/modules/2.5.28/kernel/sound/oss/sound.o
depmod:         cli
depmod:         restore_flags
depmod:         sti
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/uart401.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
depmod: *** Unresolved symbols in 
/lib/modules/2.5.28/kernel/sound/oss/v_midi.o
depmod:         cli
depmod:         restore_flags
depmod:         save_flags
make: *** [_modinst_post] Error 1

Regards.

-- 
-----------------------
-Ubaida-

 
