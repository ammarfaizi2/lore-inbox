Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEXmF>; Tue, 5 Dec 2000 18:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129874AbQLEXl4>; Tue, 5 Dec 2000 18:41:56 -0500
Received: from mout0.freenet.de ([194.97.50.131]:1417 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S129210AbQLEXlt>;
	Tue, 5 Dec 2000 18:41:49 -0500
From: mkloppstech@freenet.de
Message-Id: <200012052311.AAA06477@john.epistle>
Subject: test12-pre5 does not compile
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Dec 2000 00:11:23 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compile dummy.c into the kernel; make bzImage stops with:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686 -malign-functions=4     -c -o dummy.o dummy.c
dummy.c: In function `dummy_init_module':
dummy.c:103: invalid type argument of `->'
make[3]: *** [dummy.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.0-test12-pre5/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.0-test12-pre5/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test12-pre5/drivers'
make: *** [_dir_drivers] Error 2

Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
