Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWJaEXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWJaEXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWJaEW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:22:59 -0500
Received: from 8.ctyme.com ([69.50.231.8]:12172 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1422690AbWJaEW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:22:59 -0500
Message-ID: <4546CFA2.8000504@perkel.com>
Date: Mon, 30 Oct 2006 20:22:58 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: io_apic compile error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

getting a compile error when compiling 2.6.19rc3. Thought someone might want to fix this.

  CC      arch/x86_64/kernel/io_apic.o
arch/x86_64/kernel/io_apic.c: In function 'ioapic_pirq_setup':
arch/x86_64/kernel/io_apic.c:412: error: 'MAX_PIRQS' undeclared (first use in this function)
arch/x86_64/kernel/io_apic.c:412: error: (Each undeclared identifier is reported only once
arch/x86_64/kernel/io_apic.c:412: error: for each function it appears in.)
arch/x86_64/kernel/io_apic.c:417: error: 'pirq_entries' undeclared (first use in this function)
arch/x86_64/kernel/io_apic.c:419: error: 'pirqs_enabled' undeclared (first use in this function)
arch/x86_64/kernel/io_apic.c:412: warning: unused variable 'ints'
make[1]: *** [arch/x86_64/kernel/io_apic.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

