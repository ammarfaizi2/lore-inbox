Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbWHQPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWHQPzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWHQPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:55:38 -0400
Received: from thunk.org ([69.25.196.29]:11396 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932543AbWHQPzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:55:36 -0400
Date: Thu, 17 Aug 2006 11:52:15 -0400
From: Theodore Tso <tytso@mit.edu>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Patrick McFarland <diablod3@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL Violation?
Message-ID: <20060817155215.GA4233@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Grzegorz Kulewski <kangur@polcom.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
	Patrick McFarland <diablod3@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Anonymous User <anonymouslinuxuser@gmail.com>,
	linux-kernel@vger.kernel.org
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com> <200608170242.40969.diablod3@gmail.com> <1155797656.4494.24.camel@laptopd505.fenrus.org> <200608170332.53556.diablod3@gmail.com> <20060817080243.GN7813@stusta.de> <Pine.LNX.4.63.0608171410570.14828@alpha.polcom.net> <1155822112.15195.88.camel@localhost.localdomain> <Pine.LNX.4.63.0608171524400.14828@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608171524400.14828@alpha.polcom.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 03:31:53PM +0200, Grzegorz Kulewski wrote:
> Ok, that could be a reason. But then at least make such strong comment as 
> proposed later in my post and put it where people will be searching for it 
> - in COPYING file. Even if it will not be legally enforceable, it will 
> show the intentions of main authors and will anwser many people
> questions.

That assumes that the "main authors" want to spend time debating the
point and making an official statement --- one that might not be held
up in a court of law, afterwards.  And in fact it assumes people want
to waste time discussing this further in LKML, as well.

When I asked the question of my IP Law professor when I was taking
some classes at the Sloan School of Management 12 years ago, in his
opinion a claim that the GPL could infect across a dynamic link would
be "laughed out of court".  But that wasn't legal advice, and there
hasn't been legal precedent, and while as far as I know no court has
ruled directly on that point in the past 12 years, there may be others
that would cause a lawyer to be more or less certain about what might
happen should it ever go to court.  However, I am not a lawyer, and
neither are most people on this list.  Hence Alan's advice, "go see a
lawyer"; a lawyer will listen to the facts of your situation, apply it
to the law as it currently exists in a particular time and place, and
tender you legal advice.

But regardless of whether or not it is legal, a better and more
stronger argument is that companies that try to use proprietary binary
modules will not be able to service their customers as effectively,
and thus be at a competitive disadvantage.  From a code maintenance,
and future-proofing point of view, you really, really, really want to
have your device drivers in mainline.  In my opinion, the legal
arguments are only good for wasting bandwidth on mailing lists.

							- Ted
