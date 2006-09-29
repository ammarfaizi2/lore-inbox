Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWI2Fx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWI2Fx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 01:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWI2Fx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 01:53:29 -0400
Received: from dp.samba.org ([66.70.73.150]:31701 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S932124AbWI2Fx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 01:53:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.46192.432673.743783@samba.org>
Date: Fri, 29 Sep 2006 15:51:44 +1000
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

 > > I do think there are a few flaws in the arguments however. The biggest
 > > one for me can be summed up in the question "which license better
 > > represents the intention of the GPLv2 in the current world?"
 > 
 > Really, that's not a flaw.  Some people like GPLv2 purely on its
 > practical effect; others because of its political statements.  I think
 > Linus has summed it up much better that I can here:

I probably didn't make myself clear enough. I'm not disagreeing with
the conclusion Linus has come to. I don't have enough copyright
remaining in the Linux kernel to consider trying to influence that
decision.

I am however disagreeing with the justification given in the position
statement. The position statement implies that the FSF may be in
breach of contract, at least morally, by trying to release a version
of the GPL that is not in keeping with previous versions. I think the
preamble of the GPLv2 and the explanations given of the FSF intentions
over the years are completely consistent with the GPLv3 current draft.

As Linus has said in another thread, the FSF has been arguing this
position for many years. Their position on DRM is entirely consistent
with the original motivations for starting the GNU project, especially
when you think of the original printer story that inspired it all.

At the same time, the position Linus has taken is consistent with his
past attitude towards similar issues. I don't think it is entirely
consistent with the COPYING file that has been distributed with the
kernel all these years (especially the preamble), but thats probably
debatable.

 > but the preamble isn't part of the actual licence.  Additionally, if you
 > see the rights framed in terms of access to modifications, then GPLv3 is
 > different.

The GPLv3 is certainly different, otherwise there isn't much point in
an update. 

I would argue that the GPLv3 current draft is more consistent with the
aims of the GPLv2, as given in the preamble of the GPLv2 in numerous
speeches by Richard and other FSF members, than the GPLv2 license text
is.

So I think that the FSF have done nothing morally wrong. Whether Linus
or anyone else prefers the GPLv2 license text or the GPLv3 license
text is an entirely separate issue and not something that I have
commented on. 

 > I agree they've found ways of restricting how their hardware is used,
 > yes.  However, I tried to give a rationale of why this isn't necessarily
 > bad for the open source ecosystem as a whole here:
 > 
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=115920543731682

I am not trying to argue if its good or bad for the open source
ecosystem, at least as regards the Linux kernel. I am trying to ensure
that yourself and others understand that your criticisms of the
consistency of the FSF position are not correct.

For my own code, I think GPLv3 is a better choice. This is largely
because I have been through the pain of enforcement of GPLv2 a number
of times, and I can see that GPLv3 should make it easier, at least for
me. The language is clearer, which means less time spent on pointless
copyright law debates with various vendors. 

For other projects the relative benefits of v2 versus v3 may be
different, but I at least hope that project leaders will look at GPLv3
and make an informed decision. I think the errors in the position
statement may lead to people making incorrect judgements.

 > Actually, no, it's enshrined in GPLv2 in clause 0:
 > 
 > "Activities other than copying, distribution and modification are not
 > covered by this License; they are outside its scope.  The act of
 > running the Program is not restricted, and the output from the Program
 > is covered only if its contents constitute a work based on the
 > Program (independent of having been made by running the Program).
 > Whether that is true depends on what the Program does."
 > 
 > It's the "act of running the program is not restricted".

ok, lets take a really obvious example. Say that HP decided to
incorporate modified parts of the Linux kernel in HPUX on in their
printers. HP would be distributing the resulting image for people to
use. The fact that people are 'using' it in the end does not alter the
fact that HP would be in violation of the GPL during the act of
distribution.

So what clause 0 is saying is two things:

 1) its a basic statement of copyright law, at least in the US

 2) if someone distributes in violation of the GPL, you should go
    after the distributor, not the end users.

So as a TiVo owner, I am not in violation of the GPL. But TiVo can be
in violation for selling me something based on Linux which does not
follow the GPL.

I actually think they were already in violation with TiVo version 1,
as they were using binary kernel modules. Although it is possible to
have a kernel module which is not a derivative work of the kernel (as
address space and linking concerns are only "rules of thumb", not true
tests for a derivative work), I think that their modules were in fact
pretty clearly derived works. I can say this partly because I have
disassembled a few of them and looked at them in great detail.

 > This is really the crux of the argument with the FSF over the DRM
 > clauses.  If you take the position (as the people who signed the
 > discussion paper do) that embedded Linux constitutes an end use, then
 > this freedom from restriction of running the programme is compromised in
 > GPLv3, and hence is against the spirit of GPLv2 (and thus violates
 > clause 9 of GPLv2).

"embedded Linux constitutes end use" as a statement by itself makes no
sense. Are you really trying to argue that all embedded system vendors
get a "get out of jail free" card with regard the GPLv2?

When an embedded system vendor ships Samba as part of their system
they are very clearly distributing Samba. That has been proven time
and again in legal disputes with regards the GPL that I and others have
been involved with. The ones I have been involved with didn't end up
in court, as the lawyers and managers for these companies realised
they were wrong and quickly gave up. 

 > To go after Tivo (and not violate GPLv2 clause 9), the FSF has to take
 > the position that what Tivo is doing is not use, but is distribution.
 > This is a dangerous shift in precedent because it applies to every
 > embedded use of Linux (or any other GPL licensed programme).

No, the FSF doesn't need to take a position like that. 

A copyright license can put almost any burden it likes on a
distributor. I could have put a license on Samba saying it may not be
distributed with hardware that has more than 7pins on the main CPU. It
would have been an idiotic restriction, but it would also have been
enforceable, and vendors would have had to use a different software
package instead of Samba.

The FSF is using the DRM terms in GPLv3 to try to enforce their
original intentions, as they have explained those intentions for many
years. That is not a shift in what they have been doing for years
anyway, but the new language does make it clearer, and thus less time
consuming to enforce.

 > That's clause 11 of the current v3 Draft2:
 > 
 > "If you convey a covered work, you similarly covenant to all recipients,
 > including recipients of works based on the covered work, not to assert
 > any of your essential patent claims in the covered work."

yes, and in GPLv2, in the preamble we have:

   Finally, any free program is threatened constantly by software
 patents.  We wish to avoid the danger that redistributors of a free
 program will individually obtain patent licenses, in effect making
 the program proprietary.  To prevent this, we have made it clear that
 any patent must be licensed for everyone's free use or not licensed
 at all.

and in the main license text of GPLv2 we have:

  For example, if a patent license would not permit royalty-free
  redistribution of the Program by all those who receive copies
  directly or indirectly through you, then the only way you could
  satisfy both it and this License would be to refrain entirely from
  distribution of the Program.

Many company lawyers have objected to those terms in GPLv2 over the
years, for much the same reason you object to the patent terms in
GPLv3. I think the GPLv3 license text is a better match for the
intentions of GPLv2 (as given in the above preamble excerpt) than the
GPLv2 text is.

I also think it is worth noting that GPLv3 is arguably better for
companies with patent portfolios than GPLv2. The reason is that the
exact match for the excerpt I gave above in GPLv3 is this:

  For example, if you accept a patent license that prohibits
  royalty-free conveying by those who receive copies directly or
  indirectly through you, then the only way you could satisfy both it
  and this License would be to refrain entirely from conveying the
  Program.

Note the change from "if a patent license" to "if you accept a patent
license" ? 

That should to make life easier for companies who might be
accidentally in violation of the GPLv2 patent provisions. The "accept"
part arguably implies that you have to knowingly be in violation. The
old wording could be argued to mean you are in trouble even for
accidental violation (as can easily happen via bulk cross-licensing
deals).

 > This means that if you host a GPLv3 covered programme on your website
 > for instance (even if you didn't produce it or modify it in any way),
 > you licence any patent you hold covering it.

Many (most?) lawyers think this is already true for GPLv2, due to the
clause I quoted above.

Either way, this is very different from the statement made in the
position statement. In this position statement it said:

  As drafted, this currently looks like it would potentially
  jeopardise the entire patent portfolio of a company simply by the
  act of placing a GPLv3 licensed programme on their website

If the "entire patent portfolio" consists of a small group of patents
which specifically deal with what the code has been posted by the
company deals with, then sure. But as written the position statement
is sensationalist and very misleading, especially when the current
GPLv2 requirements regarding patents are taken into account.

 > HP is already on record as objecting to this as disproportionate.

Could you point me at their statement? I suspect it didn't use the
same words used in the position statement :-)

Cheers, Tridge
