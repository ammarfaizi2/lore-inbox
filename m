Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbUKTAz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbUKTAz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUKTAxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:53:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39335 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262743AbUKTAwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:52:45 -0500
Subject: smp_apic_timer_interrupt entry point
From: Darren Hart <darren@dvhart.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 19 Nov 2004 16:53:04 -0800
Message-Id: <1100911984.22670.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to hunt down the entry point to smp_apic_timer_interrupt()
for i386.  grep found:

arch/x86_64/kernel/entry.S:     apicinterrupt LOCAL_TIMER_VECTOR,smp_apic_timer_interrupt

but nothing for i386.  I noticed that entry.o on i386 does contain the
string "smp_apic_timer_interrupt", is there some kind of linker magic
going on?

Thanks,

-- 
Darren Hart <darren@dvhart.com>

