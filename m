Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbTHUHpj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbTHUHpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:45:38 -0400
Received: from alpha.cpe.ku.ac.th ([158.108.32.31]:4066 "EHLO
	alpha.cpe.ku.ac.th") by vger.kernel.org with ESMTP id S262500AbTHUHph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:45:37 -0400
Date: Thu, 21 Aug 2003 14:45:30 +0700 (ICT)
From: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
To: <linux-kernel@vger.kernel.org>
Subject: Cloop on Red Hat 9
Message-ID: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
	I want to create linux distribution on one CD, like Virtual
Linux. I try to use some compressed file system. I cannot use cramfs
because supported file size is too small. I try to use cloop but I cannot
compile on Red Hat 9 with kernel 2.4.20-19.9smp. Here is a error message:

cc -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -s -I.
-fno-strict-aliasing -fno-common -fomit-frame-pointer
-mpreferred-stack-boundary=2 -march=i386 -D__KERNEL__ -DMODULE
-fno-builtin -nostdlib -I/usr/src/linux-2.4.20-19.9/include -DMODVERSIONS
-include /usr/src/linux-2.4.20-19.9/include/linux/modversions.h -D__SMP__
compressed_loop.c -c -o compressed_loop.o
compressed_loop.c: In function `clo_read_from_file':
compressed_loop.c:202: too few arguments to function
`do_generic_file_read_Rsmp_5d257537'
make: *** [compressed_loop.o] Error 1

Would you tell me how to solve this problem? Or, please suggest other
compressed filesystem that support large file size.
Thanks,
Theewara

