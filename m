Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCVXES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUCVXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:04:18 -0500
Received: from ozlabs.org ([203.10.76.45]:32686 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261340AbUCVXER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:04:17 -0500
Subject: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1079996577.6595.19.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 10:02:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came across this description:

config IRQBALANCE
 	bool "Enable kernel irq balancing"
	depends on SMP && X86_IO_APIC
	default y
	help
 	  The default yes will allow the kernel to do irq load balancing.
	  Saying no will keep the kernel from doing irq load balancing.

Holy shades of preempt!  Help messages should describe the advantages
and disadvantages of an option: little more disclosure would really help
here.

IMHO, if you're having trouble describing the pros and cons of an option
to a user of average technical ability (think sysadmin), it's not a good
config option.

Rusty.	
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

