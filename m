Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRHKMAX>; Sat, 11 Aug 2001 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRHKMAN>; Sat, 11 Aug 2001 08:00:13 -0400
Received: from [212.18.191.177] ([212.18.191.177]:9231 "EHLO smtp.netc.pt")
	by vger.kernel.org with ESMTP id <S266710AbRHKMAH>;
	Sat, 11 Aug 2001 08:00:07 -0400
From: Paulo Andre <l16083@alunos.uevora.pt>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8 fails on compiling modules (emuk101)
Date: Sat, 11 Aug 2001 14:01:54 +0100
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01081114015400.05901@nirvana.local.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got the following error on compiling the emuk101 module:

make -C emu10k1 modules
make[3]: Entering directory `/usr/src/linux/drivers/sound/emu10k1'
make[3]: *** No rule to make target `emu_wrapper.h', needed by `hwaccess.h'.  
Stop.
make[3]: Leaving directory `/usr/src/linux/drivers/sound/emu10k1'
make[2]: *** [_modsubdir_emu10k1] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2
[root@nirvana linux]#

This is 2.4.8 vanilla and it used to work fine with all the pre patches 
(well, it never ever happened before).

Cheers,

// Paulo Andre'

PS - Please CC me any replies if you don't mind, I'd be grateful.

