Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbVAKRFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbVAKRFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVAKRDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:03:42 -0500
Received: from mail.dif.dk ([193.138.115.101]:11458 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262832AbVAKRCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:02:35 -0500
Date: Tue, 11 Jan 2005 18:05:05 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Chris Wright <chrisw@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve Bergman <steve@rueb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
In-Reply-To: <20050110164001.Q469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
 <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
 <20050110164001.Q469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Chris Wright wrote:

> * Jesper Juhl (juhl-lkml@dif.dk) wrote:
> > On Mon, 10 Jan 2005, Steve Bergman wrote:
> > > Actually I am having a discussion with a Pax Team member about how the recent
> > > exploits discovered by the grsecurity guys should have been handled.  They
> > > clam that they sent email to Linus and Andrew and did not receive a response
> > > for 3 weeks, and that is why they released exploit code into the wild.
> > > 
> > > Anyone here have any comments on what I should tell him?
> > > 
> > I don't know what other people would do or what the general feeling on 
> > the list is, but personally I'd send such reports to the maintainer and 
> > CC lkml, if there is no maintainer I'd just send to lkml.
> 
> Problem is, the rest of the world uses a security contact for reporting
> security sensitive bugs to project maintainers and coordinating
> disclosures.  I think it would be good for the kernel to do that as well.
> 
Problem is that the info can then get stuck at a vendor or maintainer 
outside of public view and risk being mothballed. It also limits the 
number of people who can work on a solution (including peole getting to 
work on auditing other code for similar issues). It also prevents admins 
from taking alternative precautions prior to availability of a fix (you 
have to assume the bad guys already know of the bug, not just the good 
guys).

-- 
Jesper Juhl

