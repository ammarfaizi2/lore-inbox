Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319298AbSIMHY6>; Fri, 13 Sep 2002 03:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319477AbSIMHY6>; Fri, 13 Sep 2002 03:24:58 -0400
Received: from mail.dts.de ([212.62.75.8]:22287 "HELO dtsroot.dts.intra")
	by vger.kernel.org with SMTP id <S319298AbSIMHY5>;
	Fri, 13 Sep 2002 03:24:57 -0400
Message-ID: <3D8193E0.70808@dts.de>
Date: Fri, 13 Sep 2002 09:29:36 +0200
From: Andreas Kerl <andreas.kerl@dts.de>
Reply-To: andreas.kerl@dts.de
Organization: DTS Medien GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compile error 2.4.20-pre7
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Sep 2002 07:29:45.0963 (UTC) FILETIME=[559DEBB0:01C25AF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

error compiling irtty:

make[3]: Wechsel in das Verzeichnis Verzeichnis
»/usr/src/linux-2.4.19/drivers/net/irda«
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc
-iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
irtty.c:761: (Each undeclared identifier is reported only once
irtty.c:761: for each function it appears in.)
make[3]: *** [irtty.o] Fehler 1
make[3]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.19/drivers/net/irda«
make[2]: *** [_modsubdir_irda] Fehler 2
make[2]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.19/drivers/net«
make[1]: *** [_modsubdir_net] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis
»/usr/src/linux-2.4.19/drivers«
make: *** [_mod_drivers] Fehler 2


cu

Andreas


