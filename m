Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTACUKB>; Fri, 3 Jan 2003 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTACUKA>; Fri, 3 Jan 2003 15:10:00 -0500
Received: from math.ut.ee ([193.40.5.125]:5000 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267640AbTACUKA>;
	Fri, 3 Jan 2003 15:10:00 -0500
Date: Fri, 3 Jan 2003 22:18:28 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2+bk: matroxfb compile broken
Message-ID: <Pine.GSO.4.44.0301032217080.3954-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matroxfb_base.c: In function `matroxfb_ioctl':
matroxfb_base.c:1231: `MATROXFB_TVOQUERYCTRL' undeclared (first use in this function)
matroxfb_base.c:1231: (Each undeclared identifier is reported only once
matroxfb_base.c:1231: for each function it appears in.)
matroxfb_base.c:1233: storage size of `qctrl' isn't known
matroxfb_base.c:1233: warning: unused variable `qctrl'
matroxfb_base.c:1253: `MATROXFB_G_TVOCTRL' undeclared (first use in this function)
matroxfb_base.c:1255: storage size of `ctrl' isn't known
matroxfb_base.c:1255: warning: unused variable `ctrl'
matroxfb_base.c:1275: `MATROXFB_S_TVOCTRL' undeclared (first use in this function)
matroxfb_base.c:1277: storage size of `ctrl' isn't known
matroxfb_base.c:1277: warning: unused variable `ctrl'

This is current BK on x86, matroxfb as module.

-- 
Meelis Roos (mroos@linux.ee)

