Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWBBSxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWBBSxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 13:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWBBSxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 13:53:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750998AbWBBSxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 13:53:36 -0500
Date: Thu, 2 Feb 2006 10:53:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43E24767.1090708@drzeus.cx>
Message-ID: <Pine.LNX.4.64.0602021021320.21884@g5.osdl.org>
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> 
 <43DE57C4.5010707@opersys.com>  <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
  <200601302301.04582.brcha@users.sourceforge.net>  <43E0E282.1000908@opersys.com>
  <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org>  <43E1C55A.7090801@drzeus.cx>
  <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <1138891081.9861.4.camel@localhost.localdomain>
 <Pine.LNX.4.64.0602020814320.21884@g5.osdl.org> <43E23C79.8050606@drzeus.cx>
 <Pine.LNX.4.64.0602020937360.21884@g5.osdl.org> <43E24767.1090708@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Pierre Ossman wrote:
> Linus Torvalds wrote:
> > I _literally_ feel that we do not - as software developers - have the 
> > moral right to enforce our rules on hardware manufacturers. We are not 
> > crusaders, trying to force people to bow to our superior God. We are 
> > trying to show others that co-operation and openness works better.
> 
> Then I have to ask, why GPL and not a BSD license? GPL is after all,
> forcing our beliefs onto anyone who wishes to benefit from our work.

Yes, a lot of people see the GPL as a "crusading" license, and I think 
that's partly because the FSF really has been acting like a crusader.

But I think that one of the main reasons Linux has been successful is that 
I don't think that the Linux community really is into crusading (some 
small parts of it are, but it's not the main reason). I think Linux has 
made the GPL more "socially acceptable", by being a hell of a lot less 
religious about it than the FSF was.

So to me, the point of the GPL is not the "convert the infidels" logic, 
but something totally different:

 - "quid pro quo"

   This is where I started out. My initial reason for my original license 
   (which was also "you must make changes available under the same 
   license") was not crusading, but simple reciprocity. I give out source 
   code - you can use it if you reciprocate.

   In other words, to me, the GPL "give back source" is an issue of 
   fairness. I don't ask for anything more than I give. I ask for source 
   code and the ability to incorporate your changes back into _my_ use, 
   but I don't want to limit _your_ use in any way.

   So in my worldview - not as a crusader - the GPLv2 is _fair_. It asks 
   others to give back exactly what I myself offer: the source code to 
   play with. I don't ask for control over their other projects (be they 
   hardware or software), and I don't ask for control over copyrights 
   (in the kernel, people are _encouraged_ to keep their copyrights, 
   rather than signing them over to me).

   I only ask for exact reciprocity of what I give: the license for me to 
   freely use the changes to source code that I initiated.

   The GPLv3 fundamentally changes that balance, in my opinion. It asks 
   for more than it gives. It no longer asks for just source back, it asks 
   for _control_ over whatever system you used the source in.

See? I think the GPLv3 makes _perfect_ sense as a conversion tool. But as 
a "please reciprocate in kind" tool, the GPLv2 is better.

Now, my very earliest original license (and the GPLv2) fit my notion of 
reciprocity, and as mentioned, that was the reason I _originally_ selected 
that over the BSD license. However, over time, having seen how things 
evolve, I've come to appreciate another aspect of the GPLv2, which is why 
I would never put a project I personally really cared about under the BSD 
license:

 - encouraging merging

   I've come to believe that the BSD license is not a "sustainable" 
   license, because while it encourages (and allows) forking even more 
   than the GPL does, it does not encourage merging the forks back.

   And I've come to the private conclusion that the real value of a fork 
   is lost if you don't have the ability to merge back the end result. Not 
   that all forks should be merged back - most forks are dead ends - but 
   the firm ability to merge back _if_ it turns out to be something other 
   than a dead end.

   The GPL guarantees you the right to both fork _and_ merge the result 
   back - equally, and on both sides. That makes it sustainable. In 
   contrast, the BSD license encourages forking, but also allows for not 
   merging back, and that means that if the project ever gets to the point 
   where there are economic or political reasons to diverge, it _will_ 
   eventually diverge, and there is no counter-acting force at all.

   Now, not all projects have any economic incentives to diverge: there 
   are good reasons to stay on one base, and the costs of forking are 
   bigger than the advantages. So projects like Apache and sendmail have 
   worked fine - the pain of being different (when you're "just" a network 
   service) is generally much higher than the gain of differentiation.

   But just about anywhere else, the "cohesion" of a BSD-licensed project 
   is just lower. You'll have somebody make a commercial release of it, 
   and they'll spend a bit more effort on it, and eventually the original
   freely licensed project will become immaterial.

So long-term, I believe that a GPL'd project is stabler. I believe, for 
example, that the fact that Wine switched over to the LGPL (which shares a 
lot of the cohesion argument) was a very important decision for the 
project, and that they would eventually have otherwise become irrelevant 
and the commercial users of the BSD-licensed code would have taken over.

But note that my second reason is not why I _began_ using the GPLv2, and 
that it's also equally true of the GPLv3 and LGPL. 

Anyway, there are other reasons I like the GPLv2. It's a "known entity" 
and it's been around for a long time.

In fact, even in -92, when I switched to the GPL, that "known factor" part 
was a major secondary reason for switching. I could have tried to just 
change my own license - but I felt it was an advantage to be something 
that people knew about, and not having to explain it and check it with 
lawyers. The fact that the GPLv2 was still "young" back then was nothing 
compared to how wet behind the ears my _own_ license was ;)

			Linus
