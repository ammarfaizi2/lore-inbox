Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVBJAuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVBJAuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVBJAuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:50:50 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:24715 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261993AbVBJAun
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:50:43 -0500
Date: Wed, 9 Feb 2005 16:50:41 -0800
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
       tytso@mit.edu, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050210005041.GA26312@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
	Jon Smirl <jonsmirl@gmail.com>, tytso@mit.edu,
	Stelian Pop <stelian@popies.net>,
	Francois Romieu <romieu@fr.zoreil.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20050209184629.GR22893@bitmover.com> <Pine.LNX.4.61.0502091513060.7836@localhost.localdomain> <20050209235312.GA25351@bitmover.com> <Pine.LNX.4.61.0502100109050.6118@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502100109050.6118@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 01:14:43AM +0100, Roman Zippel wrote:
> [long explanation which is summarized as "it's hard"]
> So doing the work is one thing, getting a result within my lifetime would 
> be nice too.

I understand the complexity you are facing.  This may be hard for you
to believe but we have solved problems that are quite a bit more complex
than what you are trying to do and then gave you the solution for free.

This problem is nowhere near as hard as you are making it out to be
but it is hard.  But it's not that bad, we do this every time we do
a CVS import, we have to intuit the changeset boundaries themselves,
which is actually harder than what you are trying to do.  Think about
taking revision history without any changeset grouping and recreating
the changesets (aka patches).  We do that all the time, automatically.
If we can do that then you can do this.

Yeah, it's hard, though, I admit that.  This is a bit of a cheap shot
but you did say that this stuff was easy, remember?  Yeah, you may hate
me for making you realize it is hard but maybe you'll start to respect
what it is we have given you.  That would be cool.

Anyway, you can do this.  It will probably take you a couple of months
of 80 hour weeks.  Does that suck?  Maybe.  Bear in mind that we have
given you *years* of 80 hour weeks.  Years.  Many of them unpaid.
So suck it up and get to work, we did.  

You might have fun doing this, you know.  These problems, while hard,
have some very satisfying mathematical qualities and that's really fun
coming from the kernel background where things are far less deterministic.
You can actually write proofs about how things work for a change.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
