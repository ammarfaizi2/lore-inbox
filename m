Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTIHAyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTIHAyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:54:51 -0400
Received: from hp-open.open.org ([199.2.104.1]:61626 "EHLO open.org")
	by vger.kernel.org with ESMTP id S261821AbTIHAyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:54:50 -0400
Message-ID: <3F5B7125.7050009@open.org>
Date: Sun, 07 Sep 2003 17:55:49 +0000
From: Hal <pshbro@open.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030816
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: compiler errors in 2.6.0-test4-bk8 and bk9
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered several errors in 2.6.0-test4-bk8 and bk9 relating to the 
PPC architecture.

Please do not CC back any of the comments.

I run gentoo linux (all programes are upto date) on my ibook.

1. Doing the correct kernel config needed for my ibook i ran make and 
found this.

arch/ppc/platforms/pmac_cpufreq.c: In function `pmac_cpufreq_cpu_init':
arch/ppc/platforms/pmac_cpufreq.c:260: `CPUFREQ_DEFAULT_GOVERNOR' 
undeclared (first use in this function)
arch/ppc/platforms/pmac_cpufreq.c:260: (Each undeclared identifier is 
reported only once
arch/ppc/platforms/pmac_cpufreq.c:260: for each function it appears in.)

2. After i preformed a make allyesconfig and a make i found this.

  CC      arch/ppc/kernel/asm-offsets.s
In file included from include/asm/mpc8260.h:12,
                   from include/asm/io.h:32,
                   from arch/ppc/kernel/asm-offsets.c:21:
arch/ppc/platforms/mpc82xx.h:33:30: platforms/willow.h: No such file or 
directory

