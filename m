Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284609AbRLPNig>; Sun, 16 Dec 2001 08:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284610AbRLPNi1>; Sun, 16 Dec 2001 08:38:27 -0500
Received: from [217.222.53.238] ([217.222.53.238]:48646 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id <S284609AbRLPNiQ>;
	Sun, 16 Dec 2001 08:38:16 -0500
Message-ID: <33364.62.211.145.13.1008513364.squirrel@gtsmail.gts.it>
Date: Sun, 16 Dec 2001 14:36:04 -0000 (UTC)
Subject: Compilation of 2.5.1-pre11 fails w/LVM as module
From: <s.rivoir@gts.it>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As stated in the subject, this is 'make modules' output:

make[2]: Entering directory `/us2/usr/src/linux/drivers/md'
gcc -D__KERNEL__ -I/us2/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE   -c -o lvm.o lvm.clvm.c: In function `lvm_user_bmap':
lvm.c:1046: request for member `bv_len' in something not a structure or union
make[2]: *** [lvm.o] Error 1
make[2]: Leaving directory `/us2/usr/src/linux/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/us2/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Sorry if already issued by someone else :)

Bye

-- 
Stefano




