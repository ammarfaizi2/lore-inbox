Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291213AbSAaST2>; Thu, 31 Jan 2002 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291215AbSAaSTT>; Thu, 31 Jan 2002 13:19:19 -0500
Received: from pieck.student.uva.nl ([146.50.96.22]:53435 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S291213AbSAaSTD>; Thu, 31 Jan 2002 13:19:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: rudmer <rudmer@linuxmail>
Reply-To: rudmer@linuxmail
To: linux-kernel@vger.kernel.org
Subject: 2.5.3 compile failure
Date: Thu, 31 Jan 2002 19:14:26 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02013119142604.00643@middle-earth.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i got the following error:

make[3]: Entering directory `/usr/src/linux-2.5.3/drivers/base'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.3/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4     
-DEXPORT_SYMTAB -c core.c
core.c:10: linux/malloc.h: No such file or directory
make[3]: *** [core.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.3/drivers/base'
make[1]: *** [_subdir_base] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.3/drivers'
make: *** [_dir_drivers] Error 2

This also happened when i upgraded -pre5 to -pre6. I also checked with a 
freshly downloaded tarball and after
  make mrproper; cp ../.config .; make oldconfig dep bzImage
i got the same error!


thanks,
Rudmer

please cc me as i am not on the list
