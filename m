Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUE2IjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUE2IjV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUE2IjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:39:20 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:63717 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S264076AbUE2IjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:39:19 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com>
	<2750000.1085769212@flay>
	<20040528184411.GE9898@devserv.devel.redhat.com>
From: michael@optusnet.com.au
Date: 29 May 2004 18:38:04 +1000
In-Reply-To: <20040528184411.GE9898@devserv.devel.redhat.com>
Message-ID: <m14qpz8w7n.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:
> On Fri, May 28, 2004 at 11:33:32AM -0700, Martin J. Bligh wrote:
> > Here's my start at a list ... I'm sure it's woefully incomplete.
> > 
> > 1. Utilize all CPUs roughly evenly for IRQ processing load (anything that's
> > not measured by the scheduler at least, because it's unfair to other 
> > processes).
> 
> yep; irqbalance approximates irq processing load by irq count, which seems
> to be ok-ish so far.
> 
> > Also, we may well have more than 1 CPU's worth of traffic to
> > process in a large network server.
> 
> One NIC? I've yet to see that ;)

Not too hard. Take a gig-e adaptor, add a bunch of iptables
rules, add some NAT, and you'll max out the CPU a long way
short of a gigabit...

Michael.
