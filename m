Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWHGDlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWHGDlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHGDlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:41:32 -0400
Received: from thunk.org ([69.25.196.29]:35802 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751001AbWHGDlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:41:31 -0400
Date: Sun, 6 Aug 2006 23:40:55 -0400
From: Theodore Tso <tytso@mit.edu>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807034055.GE30009@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Shem Multinymous <multinymous@gmail.com>,
	Andrew Morton <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
	gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060806005613.01c5a56a.akpm@osdl.org> <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com> <20060806030749.ab49c887.akpm@osdl.org> <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com> <20060806145551.GC30009@thunk.org> <41840b750608061508j9e731c4hf9de7b389c46c916@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608061508j9e731c4hf9de7b389c46c916@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:08:40AM +0300, Shem Multinymous wrote:
> Hi Ted,
> 
> Thanks for the explanation. Point taken, though I can't help parsing it as:
> 
> On 8/6/06, Theodore Tso <tytso@mit.edu> wrote:
> >For legal reasons, we need a way to to contact and identify the author
> >in the real world, not just in cyberspace, and a pseudonym doesn't
> >meet that requirement.
> 
> "We want to be able to sue you if they sue us."

That would be the FSF ink contract that they ask you to sign, which states:

     I hereby represent and warrant that I am the sole copyright holder for the
     Work and that I have the right and power to enter into this contract.  I
     hereby indemnify and hold harmless the Foundation, its officers, employees,
     and agents against any and all claims, actions or damages (including
     attorney's reasonable fees) asserted by or paid to any party on account of a
     breach or alleged breach of the foregoing warranty. 

(Free advice from someone who is not a lawyer: if you are _ever_ asked
to sign a contract or agreement which has the language,
"I... indemnify and hold harmless...", and you have any kind of
significant assets, like a house, car, trust fund, etc., run, don't
walk, to your friendly neighborhood lawyer and get some real legal
advice about what your exposure might be.  In any case, the rough
translation of the above is, "If anyone ever sues the FSF over code
that you are giving us for free, regardless of whether or not the
claim has any merit or not, you hereby give us permission to turn
around and sue you for any damanges _or_ legal fees that we might have
to pay out."  But don't take my word for it, talk to a lawyer first.  :-)

As far as the DCO is concerned, at least to my mind, it's so when
someone shows up, we can say, "Hey, your beef is with him, not us."
This might be especially true if the code was allegedly taken from
company X's intellectual property, and it turns out the person who
contributed it was an employee of company X.  

And in any case, it's certainly better than the FSF situation, where
the "alleged breach" language means that even if the claims are
totally bogus, and funded by some PIPE-smoking crack fairy, your
assets would still be at risk to the FSF, which wouldn't be the case
if you hadn't signed a contract with such language in it.

> >just as the fact that we aren't requiring ink signatures and public notary
> >checks doesn't mean we shouldn't stop doing what we are doing.
> 
> Understood, but still a bit silly. You have no idea how many of the
> 2252 people in `git-whatchanged | grep Signed-off-by: | sort | uniq`
> gave their legal name, and I doubt you could contact most of them in
> the real world without their cooperation (and with my cooperation, you
> could contact me too). Heck, some of those email domains don't even
> resolve. So this "chain of responsibiliy" is pretty worthless if
> someone really tries to inject legally malicious code into mainline,
> i.e., you end up blindly trusting people anyway.

Sure, but if someone really wanted, they could infect malicious code
into FSF's repositories, too.  And if we let fear paralyze us, we
wouldn't get anything done at all.  But at the same time, by having a
process, such as the DCO, we can claim that we've mad a good faith
attempt to collect a chain of accountability for contributions to the
kernel.

					- Ted

P.S.  Can you say, why you prefer contribute this from a pseudonym, if
isn't for legal reasons?
