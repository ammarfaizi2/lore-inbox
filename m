Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268483AbTBWPPG>; Sun, 23 Feb 2003 10:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268491AbTBWPOp>; Sun, 23 Feb 2003 10:14:45 -0500
Received: from host106-255.pool62211.interbusiness.it ([62.211.255.106]:54428
	"EHLO penny.tippete.net") by vger.kernel.org with ESMTP
	id <S268483AbTBWPOS>; Sun, 23 Feb 2003 10:14:18 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre4-ac5 aic7xxx compile error
Reply-To: Pierfrancesco Caci <pf@tippete.net>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: Sun, 23 Feb 2003 16:24:25 +0100
Message-ID: <87heav9g0m.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

got this error...

make[5]: Entering directory `/usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   -I.. -nostdinc -iwithprefix include -DKBUILD_BASENAME=aic7xxx_osm  -c -o aic7xxx_osm.o aic7xxx_osm.c
In file included from aic7xxx_osm.h:269,
                 from aic7xxx_osm.c:128:
aic7xxx.h:1300: syntax error before '*' token
aic7xxx.h:1306: warning: function declaration isn't a prototype
aic7xxx_osm.c: In function `ahc_linux_fallback':
aic7xxx_osm.c:3331: `MAX_OFFSET' undeclared (first use in this function)
aic7xxx_osm.c:3331: (Each undeclared identifier is reported only once
aic7xxx_osm.c:3331: for each function it appears in.)
aic7xxx_osm.c: In function `ahc_linux_queue_recovery_cmd':
aic7xxx_osm.c:4987: `NOT_IDENTIFIED' undeclared (first use in this function)
make[5]: *** [aic7xxx_osm.o] Error 1
make[5]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi/aic7xxx'
make[3]: *** [_subdir_aic7xxx] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/scsi'
make[2]: *** [_subdir_scsi] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20'
make: *** [stamp-build] Error 2


root@penny:/usr/src/linux # . scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux penny 2.4.21-pre4-ac1 #1 Sun Feb 2 16:25:57 CET 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
jfsutils               1.0.23
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-via82xx snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore bcm4400 i2c-isa


Thanks

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.21-pre4-ac1 #1 Sun Feb 2 16:25:57 CET 2003 i686 GNU/Linux

