Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSDCTJo>; Wed, 3 Apr 2002 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312335AbSDCTJe>; Wed, 3 Apr 2002 14:09:34 -0500
Received: from www.stpibonline.soft.net ([164.164.128.17]:4335 "EHLO
	cyclops.soft.net") by vger.kernel.org with ESMTP id <S312332AbSDCTJY>;
	Wed, 3 Apr 2002 14:09:24 -0500
Message-ID: <91A7E7FABAF3D511824900B0D0F95D10136FD5@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-mips-kernel@lists.sourceforge.net'" 
	<linux-mips-kernel@lists.sourceforge.net>
Cc: Abdij Bhat <Abdij.Bhat@kshema.com>
Subject: error compiling kernel for mips
Date: Thu, 4 Apr 2002 00:35:26 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 When i try compiling the Kernel for mips i get errors. The kernel is 2.4.17
downloaded from www.kernel.org. I have the mips developments environment
set. I have (hopefully) the right headers and have modified the makefile to
get the headers from those include directories.
 My main problem is changing the architecture from arch686 ( mine ) to mips.
How to i do this? What do i need to do inorder for the make to get the right
architecture? Or is there some other problem too?

 Here is the error listing

mipsel-linux-gcc -D__KERNEL__ -I/usr/tools/mipsel-linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe  -march=i686   -c -o init/main.o
init/main.c
cc1: bad value (i686) for -march= switch
Assembler messages:
Fatal error: invalid architecture -march=i686
make: *** [init/main.o] Error 2

Thanks and Regards,
Abdij

