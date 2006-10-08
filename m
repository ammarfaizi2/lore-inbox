Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWJHJue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWJHJue (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWJHJud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:50:33 -0400
Received: from www.osadl.org ([213.239.205.134]:8119 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750994AbWJHJud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:50:33 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 11:55:40 +0200
Message-Id: <1160301340.22911.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> Adds a generic sched_clock, along with a boot time override for the scheduler
> clocksource (sched_clocksource).  Hopefully the config option would eventually
> be removed.

Again, this belongs into the clocksource code and not into sched.c

Your patch series scatters clock source related code snippets all over
the place. This becomes simply a maintenance nightmare.

	tglx




