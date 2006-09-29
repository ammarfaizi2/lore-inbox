Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWI2DBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWI2DBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWI2DBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:01:46 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:40367 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932309AbWI2DBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:01:45 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tridge@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 20:01:39 -0700
Message-Id: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for posting this. It's obviously had a lot of thought go into
> it.

You're welcome ... sorry it took me a while to find this ... I'm not
subscribed to lkml, so if I'm not cc'd on the mail, I don't see the
reply (until I trawl one of the consolidator websites)

> I do think there are a few flaws in the arguments however. The biggest
> one for me can be summed up in the question "which license better
> represents the intention of the GPLv2 in the current world?"

Really, that's not a flaw.  Some people like GPLv2 purely on its
practical effect; others because of its political statements.  I think
Linus has summed it up much better that I can here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115915241428792

However, the true strength of GPLv2 was that we could all unite around
it, even if we had different beliefs (as in Free Software vs Open
Source).

> When the GPLv2 was drafted it wasn't a legal document in a vacuum. It
> came with a preamble that stated its intentions, and it came with
> someone who toured the world explaining the intentions and
> motivations. There were even plenty of repeat performances for anyone
> who wanted to attend :-)

> I think the GPLv3 does a better job of expressing legally those
> intentions than GPLv2 did. In particular this part of the v2 preamble:

>   "For example, if you distribute copies of such a program, whether
>    gratis or for a fee, you must give the recipients all the rights
>    that you have."

but the preamble isn't part of the actual licence.  Additionally, if you
see the rights framed in terms of access to modifications, then GPLv3 is
different.

> I think that recent developments (such as TiVo v2) have shown that
> companies have found ways to give recipients less rights then they
> have themselves. 

I agree they've found ways of restricting how their hardware is used,
yes.  However, I tried to give a rationale of why this isn't necessarily
bad for the open source ecosystem as a whole here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115920543731682

> So I think the parts of the position statement that talk about the
> importance of the 'development contract as expressed/represented by
> GPLv2' and the implication that this contract would be violated by the
> current GPLv3 draft are not accurate. That development contract came
> with a clear explanation (or at least it seems clear to me).
> 
> Similarly, the position statement states:
> 
>   "This in turn is brought about by a peculiar freedom enshrined in the
>   developer contract as represented by GPLv2, namely the freedom from
>   binding the end use of the project."
> 
> but I think this particular 'freedom' comes more from the development
> conventions of the Linux kernel community than from the GPLv2. I don't
> see anything in the GPLv2 that actually tried to enshrine that
> particular freedom. That doesn't mean it isn't a worthwhile thing to
> enshrine, I just think it is inaccurate to claim that the GPLv2
> attempts in any way to enshrine it.

Actually, no, it's enshrined in GPLv2 in clause 0:

"Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the Program
is covered only if its contents constitute a work based on the
Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does."

It's the "act of running the program is not restricted".

This is really the crux of the argument with the FSF over the DRM
clauses.  If you take the position (as the people who signed the
discussion paper do) that embedded Linux constitutes an end use, then
this freedom from restriction of running the programme is compromised in
GPLv3, and hence is against the spirit of GPLv2 (and thus violates
clause 9 of GPLv2).

To go after Tivo (and not violate GPLv2 clause 9), the FSF has to take
the position that what Tivo is doing is not use, but is distribution.
This is a dangerous shift in precedent because it applies to every
embedded use of Linux (or any other GPL licensed programme).

> > As drafted, this currently looks like it would potentially jeopardise the
> > entire patent portfolio of a company simply by the act of placing a GPLv3
> > licensed programme on their website.
> 
> I can't see anything in the current GPLv3 draft which would do
> that. Could you explain how that comes about?

That's clause 11 of the current v3 Draft2:

"If you convey a covered work, you similarly covenant to all recipients,
including recipients of works based on the covered work, not to assert
any of your essential patent claims in the covered work."

This means that if you host a GPLv3 covered programme on your website
for instance (even if you didn't produce it or modify it in any way),
you licence any patent you hold covering it.

HP is already on record as objecting to this as disproportionate.

James


