Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEUHSC>; Tue, 21 May 2002 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315727AbSEUHSB>; Tue, 21 May 2002 03:18:01 -0400
Received: from [210.19.28.11] ([210.19.28.11]:11394 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S314243AbSEUHSA>; Tue, 21 May 2002 03:18:00 -0400
Date: Tue, 21 May 2002 15:25:14 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.17 error (#make modules_install)
Message-Id: <20020521152514.521af318.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.7.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


#make modules_install
.......
make[4]: Leaving directory `/usr/src/linux/sound/core/seq/instr'
make[3]: Leaving directory `/usr/src/linux/sound/core/seq'
make[2]: Leaving directory `/usr/src/linux/sound/core'
make[2]: Entering directory `/usr/src/linux/sound/drivers'
mkdir -p /lib/modules/2.5.17/kernel/sound/drivers/
cp snd-dummy.o snd-virmidi.o snd-serial-u16550.o /lib/modules/2.5.17/kernel/sound/drivers/
make[3]: Entering directory `/usr/src/linux/sound/drivers/mpu401'
mkdir -p /lib/modules/2.5.17/kernel/sound/drivers/mpu401/
cp snd-mpu401-uart.o snd-mpu401.o /lib/modules/2.5.17/kernel/sound/drivers/mpu401/
make[3]: Leaving directory `/usr/src/linux/sound/drivers/mpu401'
make[3]: Entering directory `/usr/src/linux/sound/drivers/opl3'
mkdir -p /lib/modules/2.5.17/kernel/sound/drivers/opl3/
cp snd-opl3-lib.o snd-opl3-synth.o /lib/modules/2.5.17/kernel/sound/drivers/opl3/
cp: cannot stat `snd-opl3-synth.o': No such file or directory
make[3]: *** [_modinst__] Error 1
make[3]: Leaving directory `/usr/src/linux/sound/drivers/opl3'
make[2]: *** [_modinst_opl3] Error 2
make[2]: Leaving directory `/usr/src/linux/sound/drivers'
make[1]: *** [_modinst_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux/sound'
make: *** [_modinst_sound] Error 2


Regards

-Ubaida-
