Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbVIJF6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVIJF6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 01:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVIJF6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 01:58:49 -0400
Received: from are.twiddle.net ([64.81.246.98]:20378 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1030494AbVIJF6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 01:58:48 -0400
Date: Fri, 9 Sep 2005 22:58:36 -0700
From: Richard Henderson <rth@twiddle.net>
To: Jan Beulich <JBeulich@novell.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 CFI annotations
Message-ID: <20050910055836.GA28662@twiddle.net>
Mail-Followup-To: Jan Beulich <JBeulich@novell.com>,
	Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
References: <432070850200007800024465@emea1-mh.id2.novell.com> <20050908154645.GN3966@smtp.west.cox.net> <43207BA30200007800024502@emea1-mh.id2.novell.com> <20050908161334.GP3966@smtp.west.cox.net> <43214D2D02000078000247B5@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43214D2D02000078000247B5@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 08:51:57AM +0200, Jan Beulich wrote:
> >>> Tom Rini <trini@kernel.crashing.org> 08.09.05 18:13:34 >>>
> >On Thu, Sep 08, 2005 at 05:57:55PM +0200, Jan Beulich wrote:
> >
> >> >> +	CFI_ADJUST_CFA_OFFSET 4;\
> >> >> +	/*CFI_REL_OFFSET es, 0;*/\
> >> >>  	pushl %ds; \
> >> >> +	CFI_ADJUST_CFA_OFFSET 4;\
> >> >> +	/*CFI_REL_OFFSET ds, 0;*/\
> >> >
> >> >Adding new commented out code never wins new friends. :)
> >> 
> >> I know. But how would you indicate functionality belonging there
> but
> >> just not provided by the translating utilities. If that's really a
> >> problem, then I would need to teach the respective macros to ignore
> >> certain operands.
> >
> >Not provided by binutils or ?
> 
> Not provided for even by the spec; if it was just binutils missing them
> I'd have added this already.

You know this is just convention, right?  And that binutils allows
you to put any column numbers you like?  So all you have to do it
match whatever debugger you're planning to use.  Make something up.


r~
