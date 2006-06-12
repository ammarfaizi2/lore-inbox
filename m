Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWFLU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFLU1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFLU1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:27:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7867 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750744AbWFLU1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:27:20 -0400
Message-Id: <200606122025.k5CKPTGB005597@laptop11.inf.utfsm.cl>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: marty fouts <mf.danger@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter) 
In-Reply-To: Message from Bernd Petrovitsch <bernd@firmix.at> 
   of "Mon, 12 Jun 2006 10:27:23 +0200." <1150100843.26402.22.camel@tara.firmix.at> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 12 Jun 2006 16:25:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 12 Jun 2006 16:25:49 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Sat, 2006-06-10 at 19:24 -0700, marty fouts wrote:

[...]

> > It doesn't work.

> It works if it is used correctly (as any tool in the world).

Right.

> The "problem" is that postmasters on the Net must do something

It took /years/ until open relays weren't common anymore... and that is a
/simple/ measure, on by default in newer upstream packages, no admin
intervention required. DNS works badly, here in Chile a mayor ISP had a
totally broken setup for many years.

>                                                                (namely
> 1) define if they want to allow others to detect forged emails claimed
> to come from their domain

They have /very/ little to gain by that, and setting it up correctly is a
mayor hassle. It breaks people sending mail "from" the domain when they
aren't there (this is rather common for people on the road), and has no
real fix. I.e., it won't ever be done. Or it will be tried, some email from
Big Cheese doesn't go through, and it will be axed.

>                           and 2) - if yes to 1) - to get appropriate SPF
> records into DNS)

Many people have no (or very little) control over their DNS data. A spammer
can then just claim it comes from one of the millions of SPF-less domains
in the world (if they don't set up their own SPFied one...). Besides,
discussions on the spamassassin lists show that SPFied email is a rather
reliable indicator of spam as things stand today...

>                   and people must either use a "good" mail relay (and
> not just the one next door) or convince postmasters to change the SPF
> records.

Won't happen.

> > It'll break standard-abiding email.

> As you see, standards change.

Yep. But SPF breaks email, not just changes the standard. For no gain at all.

> > Do you really want that?

> Yes. Especially gmail.com should do such a thing - there is such a lot
> of - presumbly forged - @gmail.com mails in my mailboxes that
> blacklisting the whole domain causes probably more good than bad (for
> me, of course).

There is spam that really comes from gmail...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

