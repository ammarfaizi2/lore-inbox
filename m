Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFQLWc>; Mon, 17 Jun 2002 07:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSFQLWb>; Mon, 17 Jun 2002 07:22:31 -0400
Received: from isis.telemach.net ([213.143.65.10]:23305 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S293680AbSFQLW3>;
	Mon, 17 Jun 2002 07:22:29 -0400
Date: Mon, 17 Jun 2002 13:25:26 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: Compile error in opl3 sound driver
Message-Id: <20020617132526.2bb79f11.Gregor.Fajdiga@telemach.net>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

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

