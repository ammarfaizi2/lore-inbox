Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291451AbSBNLDd>; Thu, 14 Feb 2002 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291452AbSBNLDQ>; Thu, 14 Feb 2002 06:03:16 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:5139 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S291423AbSBNLC4>;
	Thu, 14 Feb 2002 06:02:56 -0500
Date: Thu, 14 Feb 2002 12:02:48 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: more compiling errors in 2.5.5-pre1
Message-ID: <Pine.LNX.4.44.0202141202240.1622-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -C block modules
make[3]: Entering directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/drivers/block'
gcc -D__KERNEL__ -I/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/include/linux/modversions.h  
-DKBUILD_BASENAME=floppy  -c -o floppy.o floppy.c
gcc -D__KERNEL__ -I/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/include/linux/modversions.h  
-DKBUILD_BASENAME=rd  -c -o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/drivers/block'
make[2]: *** [_modsubdir_block] Error 2
make[2]: Leaving directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.5.5pre1'
error: Bad exit status from /home/pau/LnxZip/tmp/rpm-tmp.8387 (%build)


-- 

Pau

