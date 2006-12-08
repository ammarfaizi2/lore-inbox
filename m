Return-Path: <linux-kernel-owner+w=401wt.eu-S1758797AbWLHTA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758797AbWLHTA1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760841AbWLHTA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:00:27 -0500
Received: from math.ut.ee ([193.40.36.2]:38755 "EHLO math.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758797AbWLHTA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:00:26 -0500
Date: Fri, 8 Dec 2006 21:00:23 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: PPC compiler error (redefinition of 'struct bug_entry')
Message-ID: <Pine.SOC.4.61.0612082059360.16172@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This if from todays git (2006-12-08):

  CC      arch/ppc/kernel/asm-offsets.s
In file included from arch/ppc/include/asm/bug.h:97,
                 from include/linux/kernel.h:18,
                 from include/asm/system.h:7,
                 from include/linux/list.h:9,
                 from include/linux/signal.h:8,
                 from arch/ppc/kernel/asm-offsets.c:11:
include/asm-generic/bug.h:10: error: redefinition of 'struct bug_entry'
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1

-- 
Meelis Roos (mroos@linux.ee)
