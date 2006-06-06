Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWFFNEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWFFNEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWFFNEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:04:34 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:9667 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932151AbWFFNEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:04:33 -0400
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p73pshmzs0z.fsf@verdi.suse.de>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <20060605013223.GD17361@havoc.gtf.org>
	 <20060605065856.GA1313@electric-eye.fr.zoreil.com>
	 <1149503559.30554.10.camel@localhost.localdomain>
	 <1149503784.3111.48.camel@laptopd505.fenrus.org>
	 <20060606020245.GN29676@moss.sous-sol.org>  <p73pshmzs0z.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 09:04:05 -0400
Message-Id: <1149599045.16247.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 09:01 +0200, Andi Kleen wrote:

> 
> > 140-odd entries which are being worked on.  It's slow and tedious,
> > but in progress. 
> 
> What I would do is to concentrate on the small cleanup patches first
> and post them as soon as you fix them. I think a lot of them were
> actually ok without changes. Then bigger stuff piece by piece. You
> don't need to wait to fix everything first.

I totally agree with this approach.  There are probably over 900 patches
that have been accepted into mainline as cleanups and bug fixes that
originated from Ingo's -rt patch set.  A lot of developers don't realize
how much the -rt patch has helped the mainline kernel.

But to keep the -rt patch maintainable, when a problem or cleanup is
discovered, we try very hard to get that fix into mainline.  That way we
don't still need to maintain it. Doesn't the Xen team do the same?

-- Steve


