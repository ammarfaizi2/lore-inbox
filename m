Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSFQL0l>; Mon, 17 Jun 2002 07:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSFQL0k>; Mon, 17 Jun 2002 07:26:40 -0400
Received: from isis.telemach.net ([213.143.65.10]:29449 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S310190AbSFQL0i>;
	Mon, 17 Jun 2002 07:26:38 -0400
Date: Mon, 17 Jun 2002 13:29:29 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: opl3 compile error in lk 2.5.22
Message-Id: <20020617132929.4060e5d8.Gregor.Fajdiga@telemach.net>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

Sorry for the earlier incomplete message.

I have problems with compiling the opl3 sound driver in lk 2.5.22.
The error message is:

opl3_oss.c:25: parse error before '*' token
opl3_oss.c:25: warning: function declaration isn't a prototype
opl3_oss.c:26: parse error before '*' token
opl3_oss.c:26: warning: function declaration isn't a prototype
opl3_oss.c:27: parse error before '*' token
opl3_oss.c:27: warning: function declaration isn't a prototype
opl3_oss.c:28: parse error before '*' token
opl3_oss.c:28: warning: function declaration isn't a prototype
opl3_oss.c:29: parse error before '*' token
opl3_oss.c:29: warning: function declaration isn't a prototype
opl3_oss.c:49: parse error before "oss_callback"
opl3_oss.c:49: warning: type defaults to `int' in declaration of `oss_callback'
opl3_oss.c:50: field name not in record or union initializer
opl3_oss.c:50: (near initialization for `oss_callback')
opl3_oss.c:50: warning: initialization makes integer from pointer without a cast
opl3_oss.c:51: field name not in record or union initializer
opl3_oss.c:51: (near initialization for `oss_callback')
opl3_oss.c:51: warning: excess elements in scalar initializer
opl3_oss.c:51: warning: (near initialization for `oss_callback')
opl3_oss.c:52: field name not in record or union initializer
opl3_oss.c:52: (near initialization for `oss_callback')
opl3_oss.c:52: warning: excess elements in scalar initializer
opl3_oss.c:52: warning: (near initialization for `oss_callback')
opl3_oss.c:53: field name not in record or union initializer
opl3_oss.c:53: (near initialization for `oss_callback')
opl3_oss.c:53: warning: excess elements in scalar initializer
opl3_oss.c:53: warning: (near initialization for `oss_callback')
opl3_oss.c:54: field name not in record or union initializer
opl3_oss.c:54: (near initialization for `oss_callback')
opl3_oss.c:54: warning: excess elements in scalar initializer
opl3_oss.c:54: warning: (near initialization for `oss_callback')
opl3_oss.c:55: field name not in record or union initializer
opl3_oss.c:55: (near initialization for `oss_callback')
opl3_oss.c:55: warning: excess elements in scalar initializer
opl3_oss.c:55: warning: (near initialization for `oss_callback')
opl3_oss.c:56: warning: data definition has no type or storage class
opl3_oss.c: In function `snd_opl3_oss_event_input':
opl3_oss.c:64: structure has no member named `oss_chset'
opl3_oss.c: In function `snd_opl3_oss_free_port':
opl3_oss.c:74: structure has no member named `oss_chset'
opl3_oss.c: In function `snd_opl3_oss_create_port':
opl3_oss.c:85: structure has no member named `oss_chset'
opl3_oss.c:86: structure has no member named `oss_chset'
opl3_oss.c:88: structure has no member named `oss_chset'
opl3_oss.c:99: structure has no member named `oss_chset'
opl3_oss.c:100: structure has no member named `oss_chset'
opl3_oss.c:106: structure has no member named `oss_chset'
opl3_oss.c:107: structure has no member named `oss_chset'
opl3_oss.c:108: structure has no member named `oss_chset'
opl3_oss.c: In function `snd_opl3_init_seq_oss':
opl3_oss.c:118: `snd_seq_oss_reg_t' undeclared (first use in this function)
opl3_oss.c:118: (Each undeclared identifier is reported only once
opl3_oss.c:118: for each function it appears in.)
opl3_oss.c:118: `arg' undeclared (first use in this function)
opl3_oss.c:121: `SNDRV_SEQ_DEV_ID_OSS' undeclared (first use in this function)
opl3_oss.c:125: structure has no member named `oss_seq_dev'
opl3_oss.c:129: `SYNTH_TYPE_FM' undeclared (first use in this function)
opl3_oss.c:131: `FM_TYPE_ADLIB' undeclared (first use in this function)
opl3_oss.c:134: `FM_TYPE_OPL3' undeclared (first use in this function)
opl3_oss.c: In function `snd_opl3_free_seq_oss':
opl3_oss.c:149: structure has no member named `oss_seq_dev'
opl3_oss.c:150: structure has no member named `oss_seq_dev'
opl3_oss.c:151: structure has no member named `oss_seq_dev'
opl3_oss.c: At top level:
opl3_oss.c:158: parse error before '*' token
opl3_oss.c:159: warning: function declaration isn't a prototype
opl3_oss.c: In function `snd_opl3_open_seq_oss':
opl3_oss.c:160: `closure' undeclared (first use in this function)
opl3_oss.c:163: `arg' undeclared (first use in this function)
opl3_oss.c:170: structure has no member named `oss_chset'
opl3_oss.c:171: structure has no member named `oss_chset'
opl3_oss.c: At top level:
opl3_oss.c:181: parse error before '*' token
opl3_oss.c:182: warning: function declaration isn't a prototype
opl3_oss.c: In function `snd_opl3_close_seq_oss':
opl3_oss.c:185: `arg' undeclared (first use in this function)
opl3_oss.c: At top level:
opl3_oss.c:210: parse error before '*' token
opl3_oss.c:212: warning: function declaration isn't a prototype
opl3_oss.c: In function `snd_opl3_load_patch_seq_oss':
opl3_oss.c:216: `arg' undeclared (first use in this function)
opl3_oss.c:219: `format' undeclared (first use in this function)
opl3_oss.c:219: `FM_PATCH' undeclared (first use in this function)
opl3_oss.c:219: `OPL3_PATCH' undeclared (first use in this function)
opl3_oss.c:220: storage size of `sbi' isn't known
opl3_oss.c:232: `count' undeclared (first use in this function)
opl3_oss.c:236: `buf' undeclared (first use in this function)
opl3_oss.c:220: warning: unused variable `sbi'
opl3_oss.c: At top level:
opl3_oss.c:323: parse error before '*' token
opl3_oss.c:325: warning: function declaration isn't a prototype
opl3_oss.c: In function `snd_opl3_ioctl_seq_oss':
opl3_oss.c:328: `arg' undeclared (first use in this function)
opl3_oss.c:330: `cmd' undeclared (first use in this function)
opl3_oss.c:331: `SNDCTL_FM_LOAD_INSTR' undeclared (first use in this function)
opl3_oss.c:335: `SNDCTL_SYNTH_MEMAVL' undeclared (first use in this function)
opl3_oss.c:338: `SNDCTL_FM_4OP_ENABLE' undeclared (first use in this function)
opl3_oss.c: At top level:
opl3_oss.c:349: parse error before '*' token
opl3_oss.c:350: warning: function declaration isn't a prototype
opl3_oss.c: In function `snd_opl3_reset_seq_oss':
opl3_oss.c:353: `arg' undeclared (first use in this function)
make[4]: *** [opl3_oss.o] Error 1
make[3]: *** [opl3] Error 2
make[2]: *** [drivers] Error 2
make[1]: *** [sound] Error 2
make: *** [modules] Error 2

The relevant part of the .config is:

CONFIG_SOUND_GAMEPORT=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

ver_linux output:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux mujo 2.4.19-pre8 #1 ned maj 19 22:52:09 CEST 2002 i586 unknown
 
Gnu C                  gcc (GCC) 3.1 Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      4.0.0
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ne2k-pci 8390 vfat fat sb sb_lib uart401 sound soundcore


If you need any more info don't hesitate to ask.

Best Regards,
Grega Fajdiga

