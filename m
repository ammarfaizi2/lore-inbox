Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUBTMMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUBTMMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:12:52 -0500
Received: from math.ut.ee ([193.40.5.125]:61071 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261172AbUBTMMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:12:50 -0500
Date: Fri, 20 Feb 2004 14:12:48 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: todc_time warings on PPC
Message-ID: <Pine.GSO.4.44.0402201409380.23390-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, there are new warning on PPC while compiling 2.6.3+current BK.

arch/ppc/syslib/todc_time.c: In function `todc_m48txx_read_val':
arch/ppc/syslib/todc_time.c:99: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:100: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:101: warning: passing arg 1 of `inb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c: In function `todc_m48txx_write_val':
arch/ppc/syslib/todc_time.c:107: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:108: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:109: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c: In function `todc_mc146818_read_val':
arch/ppc/syslib/todc_time.c:117: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:118: warning: passing arg 1 of `inb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c: In function `todc_mc146818_write_val':
arch/ppc/syslib/todc_time.c:124: warning: passing arg 2 of `outb' makes integer from pointer without a cast
arch/ppc/syslib/todc_time.c:125: warning: passing arg 2 of `outb' makes integer from pointer without a cast

-- 
Meelis Roos (mroos@linux.ee)

