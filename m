Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272371AbRHYAy3>; Fri, 24 Aug 2001 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRHYAyT>; Fri, 24 Aug 2001 20:54:19 -0400
Received: from web10903.mail.yahoo.com ([216.136.131.39]:47372 "HELO
	web10903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S272371AbRHYAyP>; Fri, 24 Aug 2001 20:54:15 -0400
Message-ID: <20010825005431.4612.qmail@web10903.mail.yahoo.com>
Date: Fri, 24 Aug 2001 17:54:31 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: Tobias Diedrich <ranma@gmx.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010825024248.J8296@router.ranmachan.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Tobias Diedrich <ranma@gmx.at> wrote:
> Brad Chapman wrote:
> 
> > 	Yes, I'm aware of that. That's why we should try to centralize the #ifdef
> > somewhere, so that everybody sees a unified interface, but at the same time, 
> > do this correctly _and_ _without_ the use of typeof().
> > 
> > 	BTW what is your opinion on the things I suggested?
> 
> Well I'm not really a kernel hacker, but I don't see how it would be possible to
> do it 
> that way without always coding both versions, so I think it's a silly Idea (sorry
> ^^;)
> We would just have to agree on one Version. If I see it correctly the whole Idea
> of
> including it into kernel.h was to remove redundant code and appearently Linus
> decided
> to also force everyone to think about what they are doing when using these macros
> by requiring the additional type argument. I too think that #ifdef's in the code
> are ugly and should be avoided.
> How are you going to centralize the #ifdef and provide a unified interface if
> one version requires two arguments, the other three ?
> Currently the change broke a few things, but those are easy to convert to the new
> interface... They will just have to decide which one to use...
> I don't see any way around that.
> 
> -- 
> Tobias					     PGP-Key: 0x9AC7E0BC

Mr. Diedrich,

	See the e-mail I sent to Mr. Viro; in it I explain one way to provide
a compat interface via a config option, but still allow people to do it the
"right" way. See also the rant at the bottom ;)

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
