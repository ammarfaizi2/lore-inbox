Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVDKQer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVDKQer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVDKQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:33:20 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:52974 "EHLO smtp4.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261838AbVDKQaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:30:21 -0400
X-ME-UUID: 20050411163010224.36D8B1C002E2@mwinf0403.wanadoo.fr
Date: Mon, 11 Apr 2005 18:25:15 +0200
To: Marco Colombo <marco@esi.it>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050411162514.GA11404@pegasos>
References: <1113235942.11475.547.camel@frodo.esi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1113235942.11475.547.camel@frodo.esi>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 06:12:22PM +0200, Marco Colombo wrote:
> [I'm not subscribed, so this in not a real reply - sorry if it breaks
>  threading somehow.]
> 
> Sven Luther wrote:
> > The ftp-master are the ones reviewing the licencing problems, and they
> are the
> > ones handling the infrastructure, and putting their responsability on the
> > stake. If they feel that some piece of software has dubious legal issues which
> > come at a risk of having them personally come on the receiving end of a legal
> > case, then they will say, no, we don't distribute this software, and that is
> > the end of it.
> 
> I've been following the whole discussion (including later messages),
> but I'm still missing one point. You seem to have investigated a lot 
> on the subject, so I'll ask you. I don't get what real legal issues
> distributors may have.
> 
> Let me explain with an example. Lets say:
> 
> A - is the Author (or rights owner) of the software (GPL'ed);
> B - is an user, who got the a copy of the software from A;
> C - is another user, who got a copy indirectly, that is from a  
>     distributor;
> D - is the distributor C got the copy from.
>  
> Now, IANAL at all. But it seems to me that B has the right to _use_ the
> software by means of GPL. As long as A thinks B doesn't break GPL, B is
> fine. All B needs to do is to fulfill GPL conditions (as a user, there's
> little to do).
> 
> C also has the right to use the software, in a very similar way. As long
> as A thinks C doesn't break GPL, C is fine.
> 
> D has the right to distribute the software, under GPL terms. As long as
> A thinks D doesn't break GPL, D is fine.
> 
> Now. It seems to me that the relationship between D (distributor) and C
> (target of the distribution) is _not_ regulated by GPL at all. GPL is a
> license, the _owner_ of the rights (A) and the recipient of some rights
> (C, as an user) are the only subjects. D _owns_ no rights on the
> software, so can't grant any to C. There's no GPL between D and C.

I think you are missing the point. D get's a licence from A, the GPL, and this
licence includes a licence, not on use, but on redistribution, and the act of
D distributing the copy to C is covered by it. In a sense A allows D to
distribute the software under the GPL to C. Now, D is only allowed to do this
distribution if he also distribute the source code of it, which he can't do
for the firmware. 

Notice also the fact that there are so many contributors to the linux kernel
in effect means that there is nobody with the full rights as A, but only a
multitude of people in the D case.

> So, even if C comes to think D is breaking GPL, all C can do is notify
> A. The GPL D is supposedly breaking is an agreement between A and D
> only. On which basis may C sue D? For breaking what agreement? It's up
> to A to sue D for breaking GPL.

This is indeed an interpretation. I am not sure myself if a user receiving
GPLed software in binary only fashion as is the case here can sue either D or
A to get access to that source code.

Now you could argue that any number of authors of GPLed bits of the linux
kernel could sue D for distributing their software as a derived work of the
binary-only bit, and the fact that D doesn't distribute the source code to the
binary bit voids any other right allowed him by the GPL, and thus he has no
right to do the distribution at all. The GPL is very clear on this topic.

> What is the risk for D, if D is distributing the source of the software
> _exactly_ in the form A publicly provides it? It's not up to D to
> produce the source, all D has to do is to provide verbatim copies of
> it to anyone D distributes the software to, on request.

Imagine one of those companies got bought up by some predatory company who
wishes us (linux, debian, redhat/suse, whoever) harm. They would then be able
to sue for damage or prejudice or whatever. And given what i have heard about
the uncertainities of the Alteon ownership, this seems indeed like a plausible
scenario, which could result in a SCO bis case.

This is the scenario i want to avoid by explicitly stating the relationships
of all copyright issues of those firmware blobs.

> Does is really matter if C thinks the source being incomplete,
> or missing? C can take the issue up with A (by means of the GPL that
> exists between A and C), but not with D, since there's no GPL between
> D and C. C is in the same position of B. If the source is incomplete,
> they may ask A to comply to the GPL, but not D. D made no promises to
> them.  

/me wonders if C then holds an illegal copy of the software, and can then be
prosecuted for piracy :)

Friendly,

Sven Luther

