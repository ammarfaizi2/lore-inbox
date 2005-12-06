Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVLFBfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVLFBfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVLFBfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:35:52 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59483
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964898AbVLFBfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:35:52 -0500
Date: Tue, 6 Dec 2005 02:35:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206013549.GP28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random> <4394E750.8020205@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394E750.8020205@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 05:20:16PM -0800, Tim Bird wrote:
> This interpretation puts kernel developers in the
> position of making the legal decision about which

An hint can hardly defined as a "legal decision".

An hint _only_ means "be careful you _might_ be illegal".

"might be" is hardly a "legal deicision", infact it's not decision at
all.

It's like a "you should check your stuff to be sure you're ok".

This is the way I understood it at least...

> Different developers are likely to have
> different viewpoints on which interfaces pose risks.

The way I understood it, is that you may be breaking the GPL even if you
don't circumvent any _GPL tag. You've to check your stuff yourself, and
if you have troubles because of a _GPL tag, it means you must check it
even more closely because you got an explicit _warning_. A warning isn't
a "legal deicsion", it's just a warning.

> I guess Linus gets the last call (as usual),
> so there's some possibility of some amount
> of uniformity here.

agreed.

> Most kernel developers will naturally tend
> towards making more symbols EXPORT_SYMBOL_GPL,
> whether there's valid legal basis for it or not.

Could be, but then those developers would be wrong. We're not required
to make a symbol as _GPL to make the module illegal. So we should be
reasonable.

> (Please let me know if there's a lawyer somewhere
> reviewing the insertion of EXPORT_SYMBOL_GPLs)

I don't think there is one, and there needs to be no one, because the
_GPL tag is not a legal decision, is an hint given from programmers to
lawyers. Programmers may be totally wrong, but we do our best to help on
the legal side too.

> David currently suggests that *all* interfaces
> be so designated.  I suspect he strongly believes
> that any use of a kernel interface creates a
> derivative work.  I have a different opinion.

This question I don't want to answer because I'm a programmer, this
requires a lawyer because this is the real _legal_decision_: what is a
derived work of the kernel is the only thing that  decides what is legal
and illegal.

> Well, if it makes sense to have developers giving out legal
> advice, then I guess so.

;) Of course I meant it makes perfect sense that it's _only_ an "hint".
