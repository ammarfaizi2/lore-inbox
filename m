Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVALVdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVALVdN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 16:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVALVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 16:30:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29142 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261329AbVALV2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:28:53 -0500
Date: Wed, 12 Jan 2005 16:03:40 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112180340.GB691@logos.cnet>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501121222590.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501121222590.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:28:14PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 12 Jan 2005, Linus Torvalds wrote:
> > 
> > So if the embargo time starts ticking from _first_ report, I'd personally
> > be perfectly happy with a policy of, say "5 working days" (aka one week), 
> > or until it was made public somewhere else.
> 
> Btw, the only thing I care about is the embargo on the _fix_.
> 
> If a bug reporter is a security house, and wants to put a longer embargo
> on announcing the bug itself, or on some other aspect of the issue (ie
> known exploits etc), and wants to make sure that they get the credit and 
> they get to be the first ones to announce the problem, that's fine by me. 
> 
> The only thing I really care about is that we can serve the people who
> depend on us by giving them source code that is as bug-free and secure as 
> we can make it. If that means that we should make the changelogs be a bit 
> less verbose because we don't want to steal the thunder from the people 
> who found the problem, that's fine.

I'm not a big fan of hiding security fixes - having a defined and clear 
list of security issues is important. Moreover, the code itself is verbose
enough for some people. 

If you release the code earlier than the embargo date, even with "non verbose 
changelogs", to best serve the people who depend on us by giving them source 
code that is as bug-free and secure as possible, you make the issue public. 

IMO the best thing is to be very verbose about security problems - giving 
credit to the people who deserve it accordingly (not stealing the thunder
from the discovers, but rather making more visible on the changelog who
they are).

The KSO (Kernel Security Officer, the new buzzword on the block) has to 
control the embargo date and be strict about it.

> One of the problems with the embargo thing has been exactly the fact that
> people couldn't even find bugs (or just uglinesses) in the fixes, because
> they were kept under wraps until the "proper date". 

Exactly, and keeping under wraps means "obscure, unclear list of security issues".
We want the other way around.

