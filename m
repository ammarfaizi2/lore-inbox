Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267975AbRG2MlH>; Sun, 29 Jul 2001 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267967AbRG2Mk5>; Sun, 29 Jul 2001 08:40:57 -0400
Received: from [212.150.191.130] ([212.150.191.130]:52941 "EHLO
	vsun14.valor.com") by vger.kernel.org with ESMTP id <S267975AbRG2Mko>;
	Sun, 29 Jul 2001 08:40:44 -0400
Message-ID: <3B64044F.65B208C2@valor.com>
Date: Sun, 29 Jul 2001 15:40:47 +0300
From: Peter Gordon <peter@valor.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.7 DAC960.c won't compile
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[1.] Kernel 2.4.7 won't compile on a Compaq ML370 Proliant
[2.] I am running RedHat 7.1 and am trying to compile the modules for
kernel 2.4.7. The computer has 2 cpus and 4GB memory.

Here is the error message

make[2]: Entering directory `/usr/src/linux-2.4.7/drivers/block'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.7/include/linux/modversions.h   -DEXPORT_SYMTAB -c
DAC960.c
DAC960.c: In function `DAC960_ProcessRequest':
DAC960.c:2771: structure has no member named `sem'
make[2]: *** [DAC960.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.7/drivers'
make: *** [_mod_drivers] Error 2



Peter

-- 
Peter Gordon
Tel: (972) 8 9432430 Ext: 129 Cell phone: 054 438029 Fax: (972) 8
9432429  
Valor Ltd, PO Box 152, Yavne 70600, Israel Email: peter@valor.com
