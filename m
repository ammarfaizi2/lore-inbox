Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWDHWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWDHWrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWDHWrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 18:47:35 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:8091 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S965038AbWDHWre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 18:47:34 -0400
Message-ID: <32947.128.2.140.234.1144536454.squirrel@128.2.140.234>
Date: Sat, 8 Apr 2006 18:47:34 -0400 (EDT)
Subject: 2.4.32: unresolved symbol unregister_qdisc
From: "George P Nychis" <gnychis@cmu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I have a kernel module that uses unregister_qdisc and register_qdisc, whenever i try to insert the module I get:
/lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol unregister_qdisc
/lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol register_qdisc

Am i missing some sort of support in the kernel?

Please CC all responses directly to me :)

Thanks!
George

