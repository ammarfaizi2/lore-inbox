Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274791AbRJAJIH>; Mon, 1 Oct 2001 05:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274796AbRJAJH5>; Mon, 1 Oct 2001 05:07:57 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:39173 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S274791AbRJAJHo>; Mon, 1 Oct 2001 05:07:44 -0400
Subject: 2.4.11-pre1:  Compile error in aironet4500_card.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99 (Preview Release)
Date: 01 Oct 2001 02:00:23 -0700
Message-Id: <1001926826.17172.75.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched the LKML archive, but found no mention of this error.

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -DEXPORT_SYMTAB -c aironet4500_card.c
aironet4500_card.c:62: parse error before `__devinitdata'
aironet4500_card.c:62: warning: type defaults to `int' in declaration of `__devinitdata'
aironet4500_card.c:63: warning: braces around scalar initializer
aironet4500_card.c:63: warning: (near initialization for `__devinitdata')
aironet4500_card.c:63: warning: excess elements in scalar initializer
aironet4500_card.c:63: warning: (near initialization for `__devinitdata')
aironet4500_card.c:63: warning: excess elements in scalar initializer
aironet4500_card.c:63: warning: (near initialization for `__devinitdata')
aironet4500_card.c:63: warning: excess elements in scalar initializer
aironet4500_card.c:63: warning: (near initialization for `__devinitdata')
aironet4500_card.c:64: warning: braces around scalar initializer
aironet4500_card.c:64: warning: (near initialization for `__devinitdata')
aironet4500_card.c:64: warning: excess elements in scalar initializer
aironet4500_card.c:64: warning: (near initialization for `__devinitdata')
aironet4500_card.c:64: warning: excess elements in scalar initializer
aironet4500_card.c:64: warning: (near initialization for `__devinitdata')
aironet4500_card.c:64: warning: excess elements in scalar initializer
aironet4500_card.c:64: warning: (near initialization for `__devinitdata')
aironet4500_card.c:64: warning: excess elements in scalar initializer
aironet4500_card.c:64: warning: (near initialization for `__devinitdata')
aironet4500_card.c:65: warning: braces around scalar initializer
aironet4500_card.c:65: warning: (near initialization for `__devinitdata')
aironet4500_card.c:65: warning: excess elements in scalar initializer
aironet4500_card.c:65: warning: (near initialization for `__devinitdata')
aironet4500_card.c:65: warning: excess elements in scalar initializer
aironet4500_card.c:65: warning: (near initialization for `__devinitdata')
aironet4500_card.c:65: warning: excess elements in scalar initializer
aironet4500_card.c:65: warning: (near initialization for `__devinitdata')
aironet4500_card.c:65: warning: excess elements in scalar initializer
aironet4500_card.c:65: warning: (near initialization for `__devinitdata')
aironet4500_card.c:66: warning: braces around scalar initializer
aironet4500_card.c:66: warning: (near initialization for `__devinitdata')
aironet4500_card.c:66: warning: excess elements in scalar initializer
aironet4500_card.c:66: warning: (near initialization for `__devinitdata')
aironet4500_card.c:67: warning: data definition has no type or storage class
aironet4500_card.c:68: `aironet4500_card_pci_tbl' undeclared here (not in a function)
make[2]: *** [aironet4500_card.o] Error 1


