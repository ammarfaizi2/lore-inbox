Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVJCO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVJCO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVJCO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:29:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:35756 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932252AbVJCO3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:29:23 -0400
Date: Mon, 3 Oct 2005 07:30:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ibm.com, mingo@elte.hu,
       manfred@colorfullife.com
Subject: Re: [PATCH] RCU torture testing
Message-ID: <20051003143009.GB1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051001182056.GA1613@us.ibm.com> <20051002210549.GA8503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002210549.GA8503@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 11:05:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The attached patch adds CONFIG_RCU_TORTURE_TEST, which enables a /proc-based
> > intense torture test of the RCU infrastructure.  This is needed due to the
> > continued changes to RCU infrastructure to accommodate dynamic ticks, CPU
> > hotplug, and so on.  Most of the code is in a separate file that is compiled
> > only if the CONFIG variable is set.  Documentation on how to run the test
> > and interpret the output is also included.
> > 
> > This code has been tested on i386 and ppc64, and an earlier version of the
> > code has seen extensive testing on a number of architectures as part of the
> > PREEMPT_RT patchset.
> > 
> > Signed-off-by: <paulmck@us.ibm.com>
> 
> Can you just run the tests from time to time inside IBM?

In principle, I could, but in practice it is appropriate for non-IBMers to
be able to test the RCU infrastructure easily and thoroughly when they
work on it.

						Thanx, Paul
