Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTHQLgU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 07:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTHQLgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 07:36:20 -0400
Received: from binky.tuxfriends.net ([212.105.197.44]:3078 "EHLO
	binky.tuxfriends.net") by vger.kernel.org with ESMTP
	id S265591AbTHQLgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 07:36:17 -0400
Message-ID: <3F3F6940.6060304@fortytwo.eu.org>
Date: Sun, 17 Aug 2003 13:38:40 +0200
From: Olaf <olaf@fortytwo.eu.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 'make modules_install' and unresolved symbols with 2.6.0-test3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-KAVCheck: binky.tuxfriends.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make modules_install for 2.6.0-test3's modules fails.

Linux gytha 2.4.20 #1 Sat Apr 26 19:26:04 CEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.21
e2fsprogs              1.27
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         mousedev hid sd_mod nls_iso8859-15 ntfs serial 
tmscsim nvidia keybdev usb-uhci



depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/char/agp/intel-agp.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/char/lp.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/busses/i2c-i801.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/busses/i2c-piix4.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/adm1021.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/it87.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/lm75.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/lm78.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/lm85.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/chips/w83781d.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/i2c-dev.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/i2c/i2c-sensor.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/parport/parport_pc.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/serial/8250.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/serial/8250_acpi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/serial/8250_pci.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/usb/host/uhci-hcd.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/usb/input/hid.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/fs/lockd/lockd.ko
depmod: *** Unresolved symbols in /lib/modules/2.6.0-test3/kernel/fs/nfs/nfs.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/fs/vfat/vfat.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-device.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-instr.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-midi-emul.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-midi-event.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-midi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-hwdep.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-pcm.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-rawmidi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-rtctimer.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-timer.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/drivers/mpu401/snd-mpu401-uart.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/drivers/opl3/snd-opl3-lib.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/drivers/opl3/snd-opl3-synth.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/pci/snd-cmipci.ko

