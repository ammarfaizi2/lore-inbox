Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279674AbRKMWSQ>; Tue, 13 Nov 2001 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279630AbRKMWSH>; Tue, 13 Nov 2001 17:18:07 -0500
Received: from adsl-64-109-110-220.dsl.gdrpmi.ameritech.net ([64.109.110.220]:3535
	"HELO tabris.domedata.com") by vger.kernel.org with SMTP
	id <S279631AbRKMWSA>; Tue, 13 Nov 2001 17:18:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Organization: Dome-S-Isle Data
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.15-pre4 compile error (gcc 2.95.3 and 3.0[12])
Date: Tue, 13 Nov 2001 17:17:51 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011113221754.09CB0FB80D@tabris.domedata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please forgive me if this is already in the archives, my usual archive is 
down (www.lib.uaa.alaska.edu) and I find MARC a bit hard to follow

When compiling 2.4.15-pre4 I get the following error 

gcc -D__KERNEL__ -I/mnt/hda3/kernel/2.4.15-pre4/linux/include -Wall- 
Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4     -c -o setup.o setup.c
setup.c: In function `c_start':
setup.c:2791: subscripted value is neither array nor pointer
setup.c:2792: warning: control reaches end of non-void function
make[1]: *** [setup.o] Error 1


Ideas?

TIA
tabris
