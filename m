Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVALUac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVALUac (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVALUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:30:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:41364 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261391AbVALU2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:28:19 -0500
Date: Wed, 12 Jan 2005 12:28:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501121222590.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Linus Torvalds wrote:
> 
> So if the embargo time starts ticking from _first_ report, I'd personally
> be perfectly happy with a policy of, say "5 working days" (aka one week), 
> or until it was made public somewhere else.

Btw, the only thing I care about is the embargo on the _fix_.

If a bug reporter is a security house, and wants to put a longer embargo
on announcing the bug itself, or on some other aspect of the issue (ie
known exploits etc), and wants to make sure that they get the credit and 
they get to be the first ones to announce the problem, that's fine by me. 

The only thing I really care about is that we can serve the people who
depend on us by giving them source code that is as bug-free and secure as 
we can make it. If that means that we should make the changelogs be a bit 
less verbose because we don't want to steal the thunder from the people 
who found the problem, that's fine.

One of the problems with the embargo thing has been exactly the fact that
people couldn't even find bugs (or just uglinesses) in the fixes, because
they were kept under wraps until the "proper date". 

			Linus
