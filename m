Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTLKOs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTLKOs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:48:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14009 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265060AbTLKOs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:48:56 -0500
Date: Thu, 11 Dec 2003 15:46:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kendall Bennett <KendallB@scitechsoft.com>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031211010327.GA27196@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312111526200.25165@earth>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
 <3FD7081D.31093.61FCFA36@localhost> <20031210221800.GM6896@work.bitmover.com>
 <Pine.LNX.4.58.0312101535170.1273@home.osdl.org> <20031211010327.GA27196@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no, SpamAssassin (score=-4.9, required 5.9,
	BAYES_00 -4.90)
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Dec 2003, Larry McVoy wrote:

> > > Not only that, I think the judge would have something to say about the
> > > fact that the modules interface is delibrately changed all the time
> > > with stated intent of breaking binary drivers.
> > 
> > Where do you people _find_ these ideas?
> 
> Oh, I don't know, years of reading this list maybe?  Come on, Linus, do
> you really need me to go surfing around to find all the postings to the
> list where people were saying that's why change is good?  I *know* you
> have said it.  Don't play dumb, you have and you know it.

i challenge you to find such posts. What maybe might have happened is that
someone said "dont change this, it changes the module API" then someone
else said "that is not a good reason at all" - which is a perfectly
correct position. Maybe sometimes an interface was changed (or even
removed) because modules used it in a really unsafe way that lead to many
bogus bugreports and stability problems. I cant remember any instance of
pure "hey, lets change this function for fun and for breaking binary
modules".

i've been around here for a long time too and i find your accusation
insulting.

and even if someone did do something deliberately, it would be completely
legal, in fact, an action expressly protected by law. It is a
technological measure that effectively controls access to a work.
Deactivating an effective technological measure is against 17 USC 1201.
(the DMCA) Believe me, most kernel copyright holders are _a lot_ less anal
about their rights than they could be. Every time Congress makes copyright
laws stronger for Disney & co, the kernel copyright gets stronger too.

	Ingo
