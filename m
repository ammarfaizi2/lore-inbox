Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTLOGJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTLOGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:08:45 -0500
Received: from dp.samba.org ([66.70.73.150]:58044 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263244AbTLOGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Fri, 12 Dec 2003 22:16:24 CDT."
             <Pine.LNX.4.58.0312122203090.23752@montezuma.fsmlabs.com> 
Date: Mon, 15 Dec 2003 16:17:24 +1100
Message-Id: <20031215060838.A6F712C21D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0312122203090.23752@montezuma.fsmlabs.com> you write:
> I think he could also add that local_irq_disable() also disables
> preemption implicitely.

True, but I don't actually mention preemption very much at all, except
in RCU.  That belongs more in the Unreliable Guide To Kernel Hacking,
IMHO.

Revising which is next weeks' job.

> Small nit, it's 'current'

Thanks fixed!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
