Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031395AbWK3UcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031395AbWK3UcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031402AbWK3UcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:32:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2208 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031395AbWK3UcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:32:07 -0500
Date: Thu, 30 Nov 2006 21:31:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061130203128.GE14696@elte.hu>
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q> <20061127123606.GA11825@elte.hu> <20061130142435.GA13372@infradead.org> <20061130154425.GB28507@elte.hu> <20061130115957.c3761331.akpm@osdl.org> <20061130201935.GA14696@elte.hu> <20061130202452.GA24987@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130202452.GA24987@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Nov 30, 2006 at 09:19:35PM +0100, Ingo Molnar wrote:
> > > I get the feeling we'd be best off if we were to revisit this in a 
> > > year or so.
> > 
> > yeah. I'd suggest merging it as-is into v2.6.20. In a year we'll 
> > have some real APIs to think about.
> 
> Agreed.  And because of that I think keeping it in drivers/ for now 
> makes a lot of sense - it's just a driver we can deprecate if/when 
> things have evolved into a real infrastructure.

yeah, with that understanding there's zero objections from me.

	Ingo
