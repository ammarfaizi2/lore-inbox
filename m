Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317818AbSGVV1D>; Mon, 22 Jul 2002 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSGVV1C>; Mon, 22 Jul 2002 17:27:02 -0400
Received: from [213.4.129.129] ([213.4.129.129]:52101 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id <S317818AbSGVV1A>;
	Mon, 22 Jul 2002 17:27:00 -0400
Date: Mon, 22 Jul 2002 23:30:21 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: Compile error 2.5.27: [ad1848_lib.o] Error 1
Message-Id: <20020722233021.4713583a.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/usr/src/unstable/sound/isa'
make[3]: Entering directory `/usr/src/unstable/sound/isa/ad1816a'
make[3]: Leaving directory `/usr/src/unstable/sound/isa/ad1816a'
make[3]: Entering directory `/usr/src/unstable/sound/isa/ad1848'
  gcc -Wp,-MD,./.ad1848_lib.o.d -D__KERNEL__ -I/usr/src/unstable/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i586 -nostdinc -iwithprefix include -DMODULE  
-DKBUILD_BASENAME=ad1848_lib -DEXPORT_SYMTAB  -c -o ad1848_lib.o
ad1848_lib.c ad1848_lib.c:1171: parse error before `alsa_ad1848_init'
ad1848_lib.c:1172: warning: return-type defaults to `int'
ad1848_lib.c:1176: parse error before `alsa_ad1848_exit'
ad1848_lib.c:1177: warning: return-type defaults to `int'
ad1848_lib.c: In function `alsa_ad1848_exit':
ad1848_lib.c:1178: warning: control reaches end of non-void function
ad1848_lib.c: At top level:
ad1848_lib.c:1181: parse error before `module_exit'
ad1848_lib.c:1182: parse error at end of input
make[3]: *** [ad1848_lib.o] Error 1
make[3]: Leaving directory `/usr/src/unstable/sound/isa/ad1848'
make[2]: *** [ad1848] Error 2
make[2]: Leaving directory `/usr/src/unstable/sound/isa'
make[1]: *** [isa] Error 2
make[1]: Leaving directory `/usr/src/unstable/sound'
make: *** [sound] Error 2
root@diego:/usr/src/unstable#

