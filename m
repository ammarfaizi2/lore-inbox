Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319255AbSHNR3o>; Wed, 14 Aug 2002 13:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319256AbSHNR3o>; Wed, 14 Aug 2002 13:29:44 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:11938 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S319255AbSHNR3n>; Wed, 14 Aug 2002 13:29:43 -0400
Message-ID: <3D5A9451.C240C27A@wanadoo.fr>
Date: Wed, 14 Aug 2002 19:33:05 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac1 does not compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've the following message :

gcc -D__KERNEL__ -I/usr/src/kernel-source-2.4.20-pre2-ac1/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=swap_state  -c -o swap_state.o swap_state.c
swap_state.c:155: macro `PAGE_BUG' used without args
make[3]: *** [swap_state.o] Erreur 1
make[3]: Leaving directory `/usr/src/kernel-source-2.4.20-pre2-ac1/mm'
make[2]: *** [first_rule] Erreur 2
make[2]: Leaving directory `/usr/src/kernel-source-2.4.20-pre2-ac1/mm'
make[1]: *** [_dir_mm] Erreur 2
make[1]: Leaving directory `/usr/src/kernel-source-2.4.20-pre2-ac1'


-------
Regards
	Jean-Luc
