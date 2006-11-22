Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161771AbWKVCSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161771AbWKVCSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967015AbWKVCSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:18:03 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:11329 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S967005AbWKVCSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:18:00 -0500
Date: Tue, 21 Nov 2006 21:17:59 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061121230314.GH2013@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0611212116560.11777-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Paul E. McKenney wrote:

> > Things may not be quite as bad as they appear.  On many architectures the
> > store-mb-load pattern will work as expected.  (In fact, I don't know which
> > architectures it might fail on.)
> 
> Several weak-memory-ordering CPUs.  :-/

Of the CPUs supported by Linux, do you know which ones will work with
store-mb-load and which ones won't?

Alan

