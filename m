Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVCKBuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVCKBuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbVCKBuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:50:21 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:38566 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263000AbVCKBuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:50:10 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Arjan van de Ven <arjan@infradead.org>
Date: Fri, 11 Mar 2005 12:49:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.63807.579725.848224@cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
In-Reply-To: message from Arjan van de Ven on Thursday March 10
References: <20050309072833.GA18878@kroah.com>
	<16944.6867.858907.990990@cse.unsw.edu.au>
	<1110449872.6291.64.camel@laptopd505.fenrus.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 10, arjan@infradead.org wrote:
> On Thu, 2005-03-10 at 21:00 +1100, Neil Brown wrote:
> > One rule that I thought would make sense, but that I don't see listed
> > is:
> > 
> >  - must fix a regression
> > 
> > If some problem was in 2.6.X and is still there in 2.6.X+1, then there
> > is no great rush to fix it for 2.6.(X+1).1, it can wait for 2.6.(X+2).
> 
> this is tricky. I mean, what if it's a datacorruption thing? Sure older
> kernels may have it too... yet at the same time it'd be nice to get it
> fixed. And once you go down this slipperly slope you end up with the
> original ruleset again, eg it must be "somehow relatively important".
> 

My position is that
 - there are lots of things that "it'd be nice to get it fixed", and
    that is what 2.6.X is for
 - It is a very slippery slope 
 - No one expect Linux to be perfect. But people do expect it to get
   better without getting worse.  It is precisely to fix this
   expectation that (I understand) 2.6.x.y was created.

If a data corruption bug has been there for 10 weeks without being
noticed, then the real risk is not that great.  We are calling it
"-release", not "-hardened".

Just my shilling-and-six worth.

NeilBrown
