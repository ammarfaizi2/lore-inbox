Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291700AbSBHSFq>; Fri, 8 Feb 2002 13:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291693AbSBHSFe>; Fri, 8 Feb 2002 13:05:34 -0500
Received: from [65.169.83.229] ([65.169.83.229]:36492 "EHLO
	hst000004380um.kincannon.olemiss.edu") by vger.kernel.org with ESMTP
	id <S291692AbSBHSFV>; Fri, 8 Feb 2002 13:05:21 -0500
Date: Fri, 8 Feb 2002 12:04:34 -0600
From: Benjamin Pharr <ben@benpharr.com>
To: linux-kernel@vger.kernel.org
Subject: Error Building 2.5.4-pre3 - ide-dma.c
Message-ID: <20020208180434.GA27399@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-pre8
X-PGP-ID: 0x6859792C
X-PGP-Key: http://www.benpharr.com/public_key.asc
X-PGP-Fingerprint: 7BF0 E432 3365 C1FC E0E3  0BE2 44E1 3E1E 6859 792C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.4-pre3/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o ide-dma.o ide-dma.c
ide-dma.c: In function `ide_raw_build_sglist':
ide-dma.c:269: structure has no member named `address'
ide-dma.c:276: structure has no member named `address'
make[3]: *** [ide-dma.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.4-pre3/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.4-pre3/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4-pre3/drivers'
make: *** [_dir_drivers] Error 2
benix:/usr/src/linux-2.5.4-pre3# 

Ben Pharr
ben@benpharr.com

