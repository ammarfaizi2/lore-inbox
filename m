Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUE2LS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUE2LS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 07:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUE2LS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 07:18:56 -0400
Received: from colin2.muc.de ([193.149.48.15]:53004 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264260AbUE2LSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 07:18:51 -0400
Date: 29 May 2004 13:18:49 +0200
Date: Sat, 29 May 2004 13:18:49 +0200
From: Andi Kleen <ak@muc.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@muc.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040529111849.GA24926@colin2.muc.de>
References: <7F740D512C7C1046AB53446D372001730182BC35@scsmsx402.amr.corp.intel.com> <20040528225426.GA89095@colin2.muc.de> <40B7E708.1030603@yahoo.com.au> <20040529100600.GA75246@colin2.muc.de> <40B8619F.8020108@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B8619F.8020108@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 08:10:39PM +1000, Nick Piggin wrote:
> Andi Kleen wrote:
> >>We're actually doing the converse of this in the sched-domain
> >>scheduler. Processes have a tendancy to follow the interrupts
> >>(ie. try to get onto the same CPU as them).
> >
> >
> >Hmm? I don't see any code in sched-domain that would care about
> >interrupts. What I'm missing?
> >
> 
> Well no, what I should have said is wakeups. We do the same
> for all wakeups, so there is nothing interrupt specific you
> are right.

wakeups are too late e.g. for network processing.

-Andi
