Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUJRUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUJRUpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUJRUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:45:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9740 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267170AbUJRUoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:44:12 -0400
Date: Mon, 18 Oct 2004 21:44:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Enough with the ad-hoc naming schemes, please
Message-ID: <20041018214407.B6344@flint.arm.linux.org.uk>
Mail-Followup-To: cliff white <cliffw@osdl.org>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20041018180851.GA28904@waste.org> <20041018113807.488969ab.cliffw@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041018113807.488969ab.cliffw@osdl.org>; from cliffw@osdl.org on Mon, Oct 18, 2004 at 11:38:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 11:38:07AM -0700, cliff white wrote:
> On Mon, 18 Oct 2004 13:08:51 -0500
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > Dear Linus,
> > 
> > I can't help but notice you've broken all the tools that rely on a
> > stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.
> > 
> > In both cases, this could have been avoided by using Marcello's 2.4
> > naming scheme. It's very simple: when you think something is "final",
> > you call it a "release candidate" and tag it "-rcX". If it works out,
> > you rename it _unmodified_ and everyone can trust that it hasn't
> > broken again in the interval. If it's not "final" and you're accepting
> > more than bugfixes, you call it a "pre-release" and tag it "-pre".
> > Then developers and testers and automated tools all know what to
> > expect.
> 
> Speaking for OSDL's automated testing team, we second this motion. 

<aol>me too</aol>  I've already made some representations to Linus
in private, and now I'm actively queueing up patches which have been
sitting around since the start of -rc1.  I, for one, no longer believe
in any naming scheme associated with mainline.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
