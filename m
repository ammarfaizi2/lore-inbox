Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTHTWCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTHTWCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:02:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262263AbTHTWCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:02:47 -0400
Message-ID: <3F43EFFB.2020104@pobox.com>
Date: Wed, 20 Aug 2003 18:02:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: build error in current 2.6-BK...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC      arch/i386/kernel/irq.o
   CC      arch/i386/kernel/vm86.o
   CC      arch/i386/kernel/ptrace.o
   CC      arch/i386/kernel/i8259.o
   CC      arch/i386/kernel/ioport.o
   CC      arch/i386/kernel/ldt.o
   CC      arch/i386/kernel/setup.o
arch/i386/kernel/setup.c: In function `parse_cmdline_early':
arch/i386/kernel/setup.c:548: error: `skip_ioapic_setup' undeclared 
(first use in this function)
arch/i386/kernel/setup.c:548: error: (Each undeclared identifier is 
reported only once
arch/i386/kernel/setup.c:548: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/setup.o] Error 1
make: *** [arch/i386/kernel] Error 2

(too slack to fix, ATM)

