Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSIHQrC>; Sun, 8 Sep 2002 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSIHQrC>; Sun, 8 Sep 2002 12:47:02 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:1952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317081AbSIHQrA>;
	Sun, 8 Sep 2002 12:47:00 -0400
Date: Sun, 8 Sep 2002 18:51:36 +0200
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Cannot compile 2.5.33 - error in sonypi.c
Message-Id: <20020908185136.77c9c00a.hanno@gmx.de>
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the attached error-message.
I use gentoo linux 1.4 with gcc 3.2

  gcc -Wp,-MD,./.sonypi.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=sonypi -DEXPORT_SYMTAB  -c -o sonypi.o sonypi.c
sonypi.c: In function `sonypi_ecrset':
sonypi.c:115: called object is not a function
sonypi.c:115: parse error before string constant
sonypi.c:115: warning: left-hand operand of comma expression has no effect
sonypi.c:115: parse error before ')' token
sonypi.c:117: called object is not a function
sonypi.c:117: parse error before string constant
sonypi.c:117: warning: left-hand operand of comma expression has no effect
sonypi.c:117: parse error before ')' token
sonypi.c:119: called object is not a function
sonypi.c:119: parse error before string constant
sonypi.c:119: warning: left-hand operand of comma expression has no effect
sonypi.c:119: parse error before ')' token
sonypi.c:121: called object is not a function
sonypi.c:121: parse error before string constant
sonypi.c:121: warning: left-hand operand of comma expression has no effect
sonypi.c:121: parse error before ')' token
sonypi.c: In function `sonypi_ecrget':
sonypi.c:126: called object is not a function
sonypi.c:126: parse error before string constant
sonypi.c:126: warning: left-hand operand of comma expression has no effect
sonypi.c:126: parse error before ')' token
sonypi.c:128: called object is not a function
sonypi.c:128: parse error before string constant
sonypi.c:128: warning: left-hand operand of comma expression has no effect
sonypi.c:128: parse error before ')' token
sonypi.c:130: called object is not a function
sonypi.c:130: parse error before string constant
sonypi.c:130: warning: left-hand operand of comma expression has no effect
sonypi.c:130: parse error before ')' token
sonypi.c: In function `sonypi_call1':
sonypi.c:190: called object is not a function
sonypi.c:190: parse error before string constant
sonypi.c:190: warning: left-hand operand of comma expression has no effect
sonypi.c:190: parse error before ')' token
sonypi.c: In function `sonypi_call2':
sonypi.c:200: called object is not a function
sonypi.c:200: parse error before string constant
sonypi.c:200: warning: left-hand operand of comma expression has no effect
sonypi.c:200: parse error before ')' token
sonypi.c:202: called object is not a function
sonypi.c:202: parse error before string constant
sonypi.c:202: warning: left-hand operand of comma expression has no effect
sonypi.c:202: parse error before ')' token
sonypi.c: In function `sonypi_call3':
sonypi.c:211: called object is not a function
sonypi.c:211: parse error before string constant
sonypi.c:211: warning: left-hand operand of comma expression has no effect
sonypi.c:211: parse error before ')' token
sonypi.c:213: called object is not a function
sonypi.c:213: parse error before string constant
sonypi.c:213: warning: left-hand operand of comma expression has no effect
sonypi.c:213: parse error before ')' token
sonypi.c:215: called object is not a function
sonypi.c:215: parse error before string constant
sonypi.c:215: warning: left-hand operand of comma expression has no effect
sonypi.c:215: parse error before ')' token
sonypi.c: In function `sonypi_set':
sonypi.c:237: called object is not a function
sonypi.c:237: parse error before string constant
sonypi.c:237: warning: left-hand operand of comma expression has no effect
sonypi.c:237: parse error before ')' token
make[2]: *** [sonypi.o] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux-2.5.33/drivers/char«
make[1]: *** [char] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux-2.5.33/drivers«
make: *** [drivers] Fehler 2
