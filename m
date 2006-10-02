Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965410AbWJBVdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbWJBVdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965411AbWJBVdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:33:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27361 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965410AbWJBVdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:33:53 -0400
Message-Id: <200610022133.k92LXO5d020760@laptop13.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc 
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Mon, 02 Oct 2006 09:40:42 MST." <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 02 Oct 2006 17:33:24 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 02 Oct 2006 17:33:24 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

[...]

> If you want a yes/no kind of thing, do it on real hard issues, like not 
> accepting email from machines that aren't registered MX gateways. Sure, 
> that will mean that people who just set up their local sendmail thing and 
> connect directly to port 25 will just not be able to email, but let's face 
> it, that's why we have ISP's and DNS in the first place.

Larger sites have ingoing (MX) machines and outgoing (no MX) ones... this
is useless. And the whole SPF fiasco shows that such mechanisms (DNS based,
remote site publishes the data) are even easier to bypass (I've seen
statistics showing that the overwhelming mayority of SPF-"protected" email
is spam).

What does work rather well is greylisting (on first try tell them to come
back later, spammers rarely retry their junk).

Add blacklists (sadly, there are few reliable ones, AFAICS) and you cut it
down even more.

And yes, there is no silver bullet. This is an arms race, get a new
anti-spam device (filter configuration, ...) and soon they will figure out
how to bypass it.

In any case, I've seen claims that around 80% of email now is spam. That
it is still only a little in LKML says that the listmasters are doing an
oustanding job.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
