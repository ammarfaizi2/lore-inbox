Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbTGJPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbTGJPiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:38:11 -0400
Received: from smtp.wp.pl ([212.77.101.161]:46935 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S269379AbTGJPhW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:37:22 -0400
Date: Thu, 10 Jul 2003 17:51:35 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: compile warnings
Message-Id: <20030710175135.1c6094d8.rmrmg@wp.pl>
In-Reply-To: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

"Nie ma takiego pliku ani katalogu"  mean " no such file or directory"
and "UWAGA: 1 z 13 wyliczonych sum kontrolnych siê NIE zgadza"  mean 
"1of 13 checked  checksums is NOT correct."

#v+
[root@slack:/usr/src/linux-2.4.22-pre4#] make dep > /dev/null
acsi.c:74:25: asm/atarihw.h: Nie ma takiego pliku ani katalogu
acsi.c:75:27: asm/atariints.h: Nie ma takiego pliku ani katalogu
acsi.c:76:28: asm/atari_acsi.h: Nie ma takiego pliku ani katalogu
acsi.c:77:29: asm/atari_stdma.h: Nie ma takiego pliku ani katalogu
acsi.c:78:29: asm/atari_stram.h: Nie ma takiego pliku ani katalogu
au1000_gpio.c:41:24: asm/au1000.h: Nie ma takiego pliku ani katalogu
au1000_gpio.c:42:29: asm/au1000_gpio.h: Nie ma takiego pliku ani
katalogu hp_psaux.c:41:26: asm/hardware.h: Nie ma takiego pliku ani
katalogu hp_psaux.c:43:21: asm/gsc.h: Nie ma takiego pliku ani katalogu
In file included from
hp_sdc.c:64:/usr/src/linux-2.4.22-pre4/include/linux/hp_sdc.h:45:26:
asm/hardware.h: Nie ma takiego pliku ani katalogu
/usr/src/linux-2.4.22-pre4/include/linux/hp_sdc.h:288:2: #error No
support for device registration on this arch yet. 
hp_sdc.c:76:21:asm/gsc.h: Nie ma takiego pliku ani katalogu 
In file included from i2c-algo-ite.c:50:
 i2c-ite.h:36:31: asm/it8172/it8172.h: Nie ma takiego pliku ani katalogu
md5sum: UWAGA: 1 z 13 wyliczonych sum kontrolnych siê NIE zgadza
rtc.c:27:25: asm/machdep.h: Nie ma takiego pliku ani katalogu
rtc.c:29:22: asm/time.h: Nie ma takiego pliku ani katalogu
via-pmu.c:36:22: asm/prom.h: Nie ma takiego pliku ani katalogu
via-pmu.c:37:25: asm/machdep.h: Nie ma takiego pliku ani katalogu
via-pmu.c:41:26: asm/sections.h: Nie ma takiego pliku ani katalogu
via-pmu.c:44:30: asm/pmac_feature.h: Nie ma takiego pliku ani katalogu
via-pmu.c:47:26: asm/sections.h: Nie ma takiego pliku ani katalogu
via-pmu.c:48:26: asm/cputable.h: Nie ma takiego pliku ani katalogu
via-pmu.c:49:22: asm/time.h: Nie ma takiego pliku ani katalogu
i2o_pci.c:393:1: warning: no newline at end of file 
In file included from nubus_syms.c:8:
/usr/src/linux-2.4.22-pre4/include/linux/nubus.h:16:23: asm/nubus.h: 
Nie ma takiego pliku ani katalogu 
audio.c:41:25: asm/audioio.h: Nie ma takiego pliku ani katalogu
amd7930.c:95:26: asm/openprom.h: Nie ma takiego pliku ani katalogu
amd7930.c:96:23: asm/oplib.h: Nie ma takiego pliku ani katalogu
amd7930.c:100:22: asm/sbus.h: Nie ma takiego pliku ani katalogu
amd7930.c:102:25: asm/audioio.h: Nie ma takiego pliku ani katalogu
dbri.c:54:26: asm/openprom.h: Nie ma takiego pliku ani katalogu
dbri.c:55:23: asm/oplib.h: Nie ma takiego pliku ani katalogu
dbri.c:59:22: asm/sbus.h: Nie ma takiego pliku ani katalogu
dbri.c:62:25: asm/audioio.h: Nie ma takiego pliku ani katalogu
su.c:78:23: asm/oplib.h: Nie ma takiego pliku ani katalogu 
su.c:80:22: asm/ebus.h: Nie ma takiego pliku ani katalogu
bbc_i2c.c: 16:23: asm/oplib.h: Nie ma takiego pliku ani katalogu
bbc_i2c.c: 17:22: asm/ebus.h: Nie ma takiego pliku ani katalogu
bbc_i2c.c: 18:26: asm/spitfire.h: Nie ma takiego pliku ani katalogu
bbc_i2c.c: 19:21: asm/bbc.h: Nie ma takiego pliku ani katalogu 
In file included from bbc_i2c.c:21:
 bbc_i2c.h:5:22: asm/ebus.h: Nie ma takiego pliku ani katalogu 
In file included from 53c700.c:142:
53c700.h:40:2: #error "Config.in must define either
CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi
core." 53c700.c:163:22: 53c700_d.h: Nie ma takiego pliku ani katalogu
fas216.c:52:23: asm/ecard.h: Nie ma takiego pliku ani katalogu
newport.c:11:21: asm/gfx.h: Nie ma takiego pliku ani katalogu
newport.c:12:21: asm/ng1.h: Nie ma takiego pliku ani katalogu
rrm.c:15:21: asm/rrm.h: Nie ma takiego pliku ani katalogu
shmiq.c:57:23: asm/shmiq.h: Nie ma takiego pliku ani katalogu
shmiq.c:58:21: asm/gfx.h: Nie ma takiego pliku ani katalogu
usema.c:38:25: asm/usioctl.h: Nie ma takiego pliku ani katalogu
tc.c:19:27: asm/addrspace.h: Nie ma takiego pliku ani katalogu
tc.c:21:30: asm/dec/machtype.h: Nie ma takiego pliku ani katalogu
tc.c:22:28: asm/dec/tcinfo.h: Nie ma takiego pliku ani katalogu
tc.c:23:30: asm/dec/tcmodule.h: Nie ma takiego pliku ani katalogu
tc.c:24:32: asm/dec/interrupts.h: Nie ma takiego pliku ani katalogu
tc.c:25:25: asm/paccess.h: Nie ma takiego pliku ani katalogu
sa1100fb.c:164:27: linux/cpufreq.h: Nie ma takiego pliku ani katalogu
sa1100fb.c:166:26: asm/hardware.h: Nie ma takiego pliku ani katalogu
sa1100fb.c:169:28: asm/mach-types.h: Nie ma takiego pliku ani katalogu
sa1100fb.c:171:30: asm/arch/assabet.h: Nie ma takiego pliku ani katalogu
sticore.c:27:26: asm/hardware.h: Nie ma takiego pliku ani katalogu
stifb.c:76:62: asm/grfioctl.h: Nie ma takiego pliku ani katalogu
In file included from zorro.c:17:
/usr/src/linux-2.4.22-pre4/include/linux/zorro.h:158:23: asm/zorro.h:
Nie ma takiego pliku ani katalogu 
zorro.c:20:25: asm/amigahw.h: Nie ma takiego pliku ani katalogu
crc32.c:34:24: crc32table.h: Nie ma takiego pliku ani katalogu
#v-

[root@slack:/usr/src/linux-2.4.22-pre4#] make bzImage > /dev/null
md5sum: UWAGA: 1 z 13 wyliczonych sum kontrolnych siê NIE zgadza
md5sum: UWAGA: 1 z 13 wyliczonych sum kontrolnych siê NIE zgadza

Is it normal?

-- 
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji
