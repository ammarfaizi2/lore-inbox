Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWJHOr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWJHOr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWJHOr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:47:26 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:14247 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751203AbWJHOr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:47:26 -0400
Subject: Re: + clocksource-update-kernel-parameters.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: tglx@linutronix.de
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160301551.22911.32.camel@localhost.localdomain>
References: <200610070153.k971rw7S020875@shell0.pdx.osdl.net>
	 <1160301551.22911.32.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 07:47:25 -0700
Message-Id: <1160318845.3693.15.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 11:59 +0200, Thomas Gleixner wrote:
> On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> > Documents two new kernel parameters,
> > 
> > timeofday_clocksource
> > sched_clocksource
> >
> > Removed old ones,
> > 
> > clocksource
> > clock
> 
> NAK.
> 
> clocksource has just replaced clock. This hit mainline in 2.6.18.
> 
> 1. we can not remove "clock" without a grace perdiod
> 2. we can not change the just created new parameter clocksource again.

True, I've been thinking about this.. I was think I could deprecate
"clocksource" and "clock" but keep them around like John originally had.

Daniel

