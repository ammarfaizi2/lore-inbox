Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJJKwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTJJKwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:52:40 -0400
Received: from math.ut.ee ([193.40.5.125]:30675 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262040AbTJJKwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:52:39 -0400
Date: Fri, 10 Oct 2003 13:52:37 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: megaraid2 compilation failure in 2.4
Message-ID: <Pine.GSO.4.44.0310101351420.1585-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=megaraid2  -c -o megaraid2.o megaraid2.c
megaraid2.c: In function `mega_find_card':
megaraid2.c:403: error: structure has no member named `lock'
megaraid2.c:618: warning: integer constant is too large for "long" type

This is todays 2.4.23-pre7+BK.

-- 
Meelis Roos (mroos@linux.ee)

