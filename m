Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTLDOVH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTLDOVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:21:07 -0500
Received: from math.ut.ee ([193.40.5.125]:920 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262181AbTLDOVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:21:00 -0500
Date: Thu, 4 Dec 2003 16:20:57 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 compile error in edd
Message-ID: <Pine.GSO.4.44.0312041620210.25354-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=setup  -DEXPORT_SYMTAB -c setup.c
setup.c: In function `copy_edd':
setup.c:734: error: `DISKSIG_BUFFER' undeclared (first use in this function)
setup.c:734: error: (Each undeclared identifier is reported only once
setup.c:734: error: for each function it appears in.)
make[1]: *** [setup.o] Error 1

DISKSIG_BUFFER is nowhere to be seen.

-- 
Meelis Roos (mroos@linux.ee)

