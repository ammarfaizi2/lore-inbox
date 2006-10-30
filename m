Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWJ3NVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWJ3NVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWJ3NVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:21:45 -0500
Received: from poczta.o2.pl ([193.17.41.142]:4491 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030191AbWJ3NVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:21:44 -0500
Date: Mon, 30 Oct 2006 14:27:14 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] lockdep: spin_lock_irqsave_nested()
Message-ID: <20061030132714.GB1657@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
	David Woodhouse <dwmw2@infradead.org>
References: <1162199005.24143.169.camel@taijtu> <20061030131241.GA1657@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030131241.GA1657@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 02:12:41PM +0100, Jarek Poplawski wrote:
> Here are some doubts...
...
> On 30-10-2006 10:03, Peter Zijlstra wrote:
> > From: Arjan van de Ven <arjan@linux.intel.com>
> > Subject: spin_lock_irqsave_nested()
> > +EXPORT_SYMBOL(_spin_lock_irqsave_nested);
> >  
> >  #endif
> >  
> > 
> 
> Shouldn't this _nested locks be considered in: 
> #else /* CONFIG_PREEMPT: */
> part?

Sorry, this one is not my doubt anymore.

Jarek P.
