Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135942AbRDVI6P>; Sun, 22 Apr 2001 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135947AbRDVI6G>; Sun, 22 Apr 2001 04:58:06 -0400
Received: from CPE-61-9-151-92.vic.bigpond.net.au ([61.9.151.92]:50427 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S135942AbRDVI5z>;
	Sun, 22 Apr 2001 04:57:55 -0400
Message-ID: <3AE29CFD.C438C8B9@eyal.emu.id.au>
Date: Sun, 22 Apr 2001 18:57:33 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 2.4.3-ac12

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
-DMODVERSIONS -include
/data2/usr/local/src/linux-2.4/include/linux/modversions.h   -c -o
inode.o inode.c
inode.c: In function `affs_notify_change':
inode.c:236: void value not ignored as it ought to be
make[2]: *** [inode.o] Error 1
make[2]: Leaving directory `/data2/usr/local/src/linux-2.4/fs/affs'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
