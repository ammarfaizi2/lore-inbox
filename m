Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132968AbRADUKJ>; Thu, 4 Jan 2001 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132975AbRADUJ7>; Thu, 4 Jan 2001 15:09:59 -0500
Received: from pop.gmx.net ([194.221.183.20]:37212 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132968AbRADUJu>;
	Thu, 4 Jan 2001 15:09:50 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: prerelease-_ac6 : make modules with error
Date: Thu, 4 Jan 2001 21:06:12 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01010421061200.00868@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan,

a make modules on 2.4.0-prerelease-ac6 exits with error:

make[2]: Entering directory `/usr/src/linux-2.4.0ac6/drivers/char'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i586 -DMODULE -DMODVERSIONS -include 
/usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c serial.c
serial.c: In function `probe_serial_pnp':
serial.c:5187: structure has no member named `device'
serial.c:5192: structure has no member named `device'
make[2]: *** [serial.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.0ac6/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0ac6/drivers'
make: *** [_mod_drivers] Error 2

kind regards

Norbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
