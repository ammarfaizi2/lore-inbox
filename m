Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289821AbSAOOmy>; Tue, 15 Jan 2002 09:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAOOmo>; Tue, 15 Jan 2002 09:42:44 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29712 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289821AbSAOOmj>; Tue, 15 Jan 2002 09:42:39 -0500
Date: Tue, 15 Jan 2002 12:53:27 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115115327.GB10883@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com> <20020114183820.G30639@redhat.com> <20020114205307.E24120@thyrsus.com> <20020114213641.I30639@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20020114213641.I30639@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Benjamin LaHaise wrote:

> On Mon, Jan 14, 2002 at 08:53:07PM -0500, Eric S. Raymond wrote:
> > I don't understand what you think you're seeing, but I am sure of
> > this; if I had been enough of a drug-addled lunatic to allow fetchmail
> > to delete mail before getting a positive acknowledge from the
> > downstream MTA, someone in the pool of over two thousand people who have sent
> > me bug reports and patches would have called me on it some time in the
> > six years of production use well before *you* entered the picture.
> 
> Uhm, as someone who has run a number of mailing lists for the past 6 
> years, I've seen fetchmail induced bounces numerous times, and 99% of 
> the time they're because the damn thing should default to a 
> --never-send-bounces-to-anyone.

It doesn't matter if people hose their qmail forwards without fetchmail
anywhere, a provider fails to provide envelope information for that dung
of pile that a multidrop POP3 mailbox is, somehow you can always screw
up mailing lists. Use VERP to figure who is bouncing on you. And now
please take this off-list.

> That's part of what you have to deal with by being a hybrid MTA/MUA: 
> your error handling must be directed at the user of fetchmail, not the 
> originator of the message.  The originator of the message has no control 

You have absolutely no clue of fetchmail. Get lost. Please. Come back
only after you got the *complete* fetchmail picture.

fetchmail does not bounce on its own for single-drop mailboxes, and as
long as 4.x.y or 5.3.x versions are still around on distributions, ESR
cannot do much about solutions you require either because users won't
get hold of the policy changes.

> the fact that fetchmail *is* an MUA -> it should not behave as if it is 
> purely an MTA.

Fetchmail is by no means a MUA.

> Besides, I think you're trying to solve the wrong problem.  A good many 
> readers of linux-kernel don't want to start seeing posts from Aunt Tillie 
> and would rather leave this ease of use issue to the distributions that 
> already make it easy as pie.

Having a common solution upstream is the way to save duplicate efforts.

And now let the fetchmail part of this thread please die.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
