Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbTGCKbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 06:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbTGCKbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 06:31:31 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:52904 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S265925AbTGCKbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 06:31:24 -0400
Subject: Re: 2.5.74-mm1 (p4-clockmod does not compile)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030703023714.55d13934.akpm@osdl.org>
References: <20030703023714.55d13934.akpm@osdl.org>
Content-Type: text/plain
Organization: iNES Group SRL
Message-Id: <1057229141.1479.16.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-3) 
Date: 03 Jul 2003 13:45:41 +0300
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are the errors:

  CC      arch/i386/kernel/cpu/cpufreq/p4-clockmod.o
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c: In function `cpufreq_p4_setdc':
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:67: error: incompatible types in assignment
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:78: error: incompatible type for argument 2 of `set_cpus_allowed'
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:90: error: incompatible type for argument 2 of `set_cpus_allowed'
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c:131: error: incompatible type for argument 2 of `set_cpus_allowed'
make[3]: *** [arch/i386/kernel/cpu/cpufreq/p4-clockmod.o] Error 1
make[2]: *** [arch/i386/kernel/cpu/cpufreq] Error 2
make[1]: *** [arch/i386/kernel/cpu] Error 2
make: *** [arch/i386/kernel] Error 2




