Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSFELJT>; Wed, 5 Jun 2002 07:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315170AbSFELJS>; Wed, 5 Jun 2002 07:09:18 -0400
Received: from ulima.unil.ch ([130.223.144.143]:35470 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S314787AbSFELJR>;
	Wed, 5 Jun 2002 07:09:17 -0400
Date: Wed, 5 Jun 2002 13:09:13 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.20 don't compil...
Message-ID: <20020605110912.GA21939@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got:

make[2]: Entering directory `/usr/src/linux-2.5/drivers/scsi'
gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE
-DKBUILD_BASENAME=sym53c416  -c -o sym53c416.o sym53c416.c
sym53c416.c: In function `sym53c416_intr_handle':
sym53c416.c:452: structure has no member named `address'
sym53c416.c:478: structure has no member named `address'
make[2]: *** [sym53c416.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [_mod_drivers] Error 2

I have already reported that problem, and sent a patch to this list...

What should I do?

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
