Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269718AbTGKADu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbTGKADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:03:50 -0400
Received: from smtp.wp.pl ([212.77.101.161]:56496 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S269718AbTGKADq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:03:46 -0400
Date: Fri, 11 Jul 2003 02:18:25 +0200
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: Diego Calleja =?ISO-8859-2?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile warnings
Message-Id: <20030711021825.1ee5e7e8.rmrmg@wp.pl>
In-Reply-To: <20030711002607.6b82540f.diegocg@teleline.es>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
	<20030710175135.1c6094d8.rmrmg@wp.pl>
	<20030711002607.6b82540f.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Diego Calleja García <diegocg@teleline.es> quote:

>could you recompile with "LC_ALL='C' make whatever" ?


#v+
 [root@slack:/usr/src/linux-2.4.22-pre4#]LC_ALL='C' make dep > /dev/null
acsi.c:74:25: asm/atarihw.h: No such file or directory
acsi.c:75:27: asm/atariints.h: No such file or directory
acsi.c:76:28: asm/atari_acsi.h: No such file or directory
acsi.c:77:29: asm/atari_stdma.h: No such file or directory
acsi.c:78:29: asm/atari_stram.h: No such file or directory
au1000_gpio.c:41:24: asm/au1000.h: No such file or directory
au1000_gpio.c:42:29: asm/au1000_gpio.h: No such file or directory
hp_psaux.c:41:26: asm/hardware.h: No such file or directory
hp_psaux.c:43:21: asm/gsc.h: No such file or directory
In file included from hp_sdc.c:64:
/usr/src/linux-2.4.21/include/linux/hp_sdc.h:45:26: asm/hardware.h: No
such file or
directory/usr/src/linux-2.4.21/include/linux/hp_sdc.h:288:2: #error No
support for device registration on this arch yet. hp_sdc.c:76:21:
asm/gsc.h: No such file or directory In file included from
i2c-algo-ite.c:50: i2c-ite.h:36:31: asm/it8172/it8172.h: No such file or
directory 
md5sum: WARNING: 1 of 13 computed checksums did NOT match
rtc.c:27:25: asm/machdep.h: No such file or directory
rtc.c:29:22: asm/time.h: No such file or directory
via-pmu.c:36:22: asm/prom.h: No such file or directory
via-pmu.c:37:25: asm/machdep.h: No such file or directory
via-pmu.c:41:26: asm/sections.h: No such file or directory
via-pmu.c:44:30: asm/pmac_feature.h: No such file or directory
via-pmu.c:47:26: asm/sections.h: No such file or directory
via-pmu.c:48:26: asm/cputable.h: No such file or directory
via-pmu.c:49:22: asm/time.h: No such file or directory
i2o_pci.c:393:1: warning: no newline at end of file
In file included from nubus_syms.c:8:
/usr/src/linux-2.4.21/include/linux/nubus.h:16:23: asm/nubus.h: No such
file or directory audio.c:41:25: asm/audioio.h: No such file or
directory amd7930.c:95:26: asm/openprom.h: No such file or directory
amd7930.c:96:23: asm/oplib.h: No such file or directory
amd7930.c:100:22: asm/sbus.h: No such file or directory
amd7930.c:102:25: asm/audioio.h: No such file or directory
dbri.c:54:26: asm/openprom.h: No such file or directory
dbri.c:55:23: asm/oplib.h: No such file or directory
dbri.c:59:22: asm/sbus.h: No such file or directory
dbri.c:62:25: asm/audioio.h: No such file or directory
su.c:78:23: asm/oplib.h: No such file or directory
su.c:80:22: asm/ebus.h: No such file or directory
bbc_i2c.c:16:23: asm/oplib.h: No such file or directory
bbc_i2c.c:17:22: asm/ebus.h: No such file or directory
bbc_i2c.c:18:26: asm/spitfire.h: No such file or directory
bbc_i2c.c:19:21: asm/bbc.h: No such file or directory
In file included from bbc_i2c.c:21:
bbc_i2c.h:5:22: asm/ebus.h: No such file or directory
In file included from 53c700.c:142:
53c700.h:40:2: #error "Config.in must define either
CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi
core." 
53c700.c:163:22: 53c700_d.h: No such file or directory
fas216.c:52:23: asm/ecard.h: No such file or directory
newport.c:11:21: asm/gfx.h: No such file or directory
newport.c:12:21: asm/ng1.h: No such file or directory
rrm.c:15:21: asm/rrm.h: No such file or directory
shmiq.c:57:23: asm/shmiq.h: No such file or directory
shmiq.c:58:21: asm/gfx.h: No such file or directory
usema.c:38:25: asm/usioctl.h: No such file or directory
tc.c:19:27: asm/addrspace.h: No such file or directory
tc.c:21:30: asm/dec/machtype.h: No such file or directory
tc.c:22:28: asm/dec/tcinfo.h: No such file or directory
tc.c:23:30: asm/dec/tcmodule.h: No such file or directory
tc.c:24:32: asm/dec/interrupts.h: No such file or directory
tc.c:25:25: asm/paccess.h: No such file or directory
sa1100fb.c:164:27: linux/cpufreq.h: No such file or directory
sa1100fb.c:166:26: asm/hardware.h: No such file or directory
sa1100fb.c:169:28: asm/mach-types.h: No such file or directory
sa1100fb.c:171:30: asm/arch/assabet.h: No such file or directory
sticore.c:27:26: asm/hardware.h: No such file or directory
stifb.c:76:62: asm/grfioctl.h: No such file or directory
In file included from zorro.c:17:
/usr/src/linux-2.4.21/include/linux/zorro.h:158:23: asm/zorro.h: 
No such file or directory 
zorro.c:20:25: asm/amigahw.h: 
No such file or directory 
crc32.c:34:24: crc32table.h: No such file or directory
#v-

[root@slack:/usr/src/linux-2.4.22-pre4#] LC_ALL='C' make bzImage >
/dev/null
md5sum: WARNING: 1 of 13 computed checksums did NOT match
md5sum: WARNING: 1 of 13 computed checksums did NOT match

--  
registered Linux user 261525 | Wszystko jest trudne przy
gg 2311504________rmrmg@wp.pl|    odpowiednim stopniu
RMRMG signature version 0.0.2|        abstrakcji
