Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWJHOpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWJHOpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWJHOpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:45:51 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:61606 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750855AbWJHOpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:45:51 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160301340.22911.27.camel@localhost.localdomain>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 07:45:50 -0700
Message-Id: <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 11:55 +0200, Thomas Gleixner wrote:
> On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > Adds a generic sched_clock, along with a boot time override for the scheduler
> > clocksource (sched_clocksource).  Hopefully the config option would eventually
> > be removed.
> 
> Again, this belongs into the clocksource code and not into sched.c
> 
> Your patch series scatters clock source related code snippets all over
> the place. This becomes simply a maintenance nightmare.

It's an API, it's suppose to be used in different places.  

Daniel

