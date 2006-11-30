Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031375AbWK3UZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031375AbWK3UZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031382AbWK3UZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:25:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46042 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031375AbWK3UZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:25:03 -0500
Date: Thu, 30 Nov 2006 20:24:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061130202452.GA24987@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q> <20061127123606.GA11825@elte.hu> <20061130142435.GA13372@infradead.org> <20061130154425.GB28507@elte.hu> <20061130115957.c3761331.akpm@osdl.org> <20061130201935.GA14696@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130201935.GA14696@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:19:35PM +0100, Ingo Molnar wrote:
> > I get the feeling we'd be best off if we were to revisit this in a 
> > year or so.
> 
> yeah. I'd suggest merging it as-is into v2.6.20. In a year we'll have 
> some real APIs to think about.

Agreed.  And because of that I think keeping it in drivers/ for now
makes a lot of sense - it's just a driver we can deprecate if/when things
have evolved into a real infrastructure.
