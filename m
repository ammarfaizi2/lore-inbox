Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSENRRN>; Tue, 14 May 2002 13:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315892AbSENRRM>; Tue, 14 May 2002 13:17:12 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:25036 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315893AbSENRRI> convert rfc822-to-8bit; Tue, 14 May 2002 13:17:08 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-kernel@vger.kernel.org
Subject: any1 have a clue?
Date: Tue, 14 May 2002 19:16:51 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205141916.51818.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there :-)

anyone have a clue what "disabled" is in 2.4.18 tree?
I want to integrate the vmwarefb driver posted on this list for 2.4.19pre8 
into 2.4.18 ... Or does anyone test this on 2.4.19pre8 with the same problem?

cc  -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-Wno-unused -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  
-DKBUILD_BASENAME=vmwarefb  -c -o vmwarefb.o vmwarefb.c
vmwarefb.c: In function `init_module':
vmwarefb.c:1513: `disabled' undeclared (first use in this function)
vmwarefb.c:1513: (Each undeclared identifier is reported only once
vmwarefb.c:1513: for each function it appears in.)
make[3]: *** [vmwarefb.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.18/drivers/video/vmware'
make[2]: *** [_modsubdir_vmware] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/video'
make[1]: *** [_modsubdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.18/drivers'
make: *** [_mod_drivers] Error 2

Kind regards,
	Marc

