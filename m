Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272839AbRILOmx>; Wed, 12 Sep 2001 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272843AbRILOmo>; Wed, 12 Sep 2001 10:42:44 -0400
Received: from dialin-212-144-133-148.arcor-ip.net ([212.144.133.148]:54276
	"HELO majestix.jcs-consale.de") by vger.kernel.org with SMTP
	id <S272839AbRILOm2>; Wed, 12 Sep 2001 10:42:28 -0400
From: Eric Jourdan (Drake) <Eric.Jourdan@JCS-ConSale.de>
Organization: JCS ConSale
To: linux-kernel@vger.kernel.org
Subject: Errormessage while compiling Kernel
Date: Wed, 12 Sep 2001 16:45:06 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01091216455601.03859@majestix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy there,
I got a error message while I tried to compile the kernel 2.4.8.

Here are the last messages from the console:

mv /programme/src/linux-2.4.8/include/linux/modules/slhc.ver.tmp /programme/src/linux-2.4.8/include/linux/modules/slhc.ver
gcc -D__KERNEL__ -I/programme/src/linux-2.4.8/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586  -E -D__GENKSYMS__ pppox.c
| /sbin/genksyms -p smp_ -k 2.4.8 > /programme/src/linux-2.4.8/include/linux/modules/pppox.ver.tmp
mv /programme/src/linux-2.4.8/include/linux/modules/pppox.ver.tmp /programme/src/linux-2.4.8/include/linux/modules/pppox.ver
make[4]: *** [/programme/src/linux-2.4.8/include/linux/modules/auto_irq.ver] Segmentation fault
make[4]: Leaving directory `/programme/src/linux-2.4.8/drivers/net'
make[3]: *** [_sfdep_net] Error 2
make[3]: Leaving directory `/programme/src/linux-2.4.8/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/programme/src/linux-2.4.8/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/programme/src/linux-2.4.8'
make: *** [dep-files] Error 2

Is this an error from the kernel or is this a failure from my system?

Thanx

CU

Drake
