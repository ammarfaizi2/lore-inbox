Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWH1Qd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWH1Qd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH1Qd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:33:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8115 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751185AbWH1Qd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:33:26 -0400
Subject: Re: [PATCH 0/4] RCU: various merge candidates
From: Arjan van de Ven <arjan@infradead.org>
To: dipankar@in.ibm.com
Cc: Paul E McKenney <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060828162904.GG3325@in.ibm.com>
References: <20060828160845.GB3325@in.ibm.com>
	 <1156781748.3034.212.camel@laptopd505.fenrus.org>
	 <20060828162904.GG3325@in.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 18:33:09 +0200
Message-Id: <1156782789.3034.216.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 21:59 +0530, Dipankar Sarma wrote:
> On Mon, Aug 28, 2006 at 06:15:48PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-08-28 at 21:38 +0530, Dipankar Sarma wrote:
> > > This patchset consists of various merge candidates that would
> > > do well to have some testing in -mm. This patchset breaks
> > > out RCU implementation from its APIs to allow multiple
> > > implementations, 
> > 
> > 
> > can you explain why we would want multiple RCU implementations?
> > Isn't one going to be plenty already?
> 
> Hi Arjan,
> 
> See this for a background - http://lwn.net/Articles/129511/
> 
> Primarily, rcupreempt allows read-side critical sections to
> be preempted unline classic RCU currently in mainline. It is
> also a bit more aggressive in terms of grace periods by counting
> the number of readers as opposed to periodic checks in classic
> RCU.
> 

hi,

thanks for the explenation, this for sure explains one half of the
equation; the other half is ... "why do we not always want this"?

Greetings,
   Arjan van de Ven

