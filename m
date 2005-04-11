Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVDKQTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVDKQTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDKQQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:16:02 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:48849 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261836AbVDKQMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:12:24 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Marco Colombo <marco@esi.it>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: ESI srl
Date: Mon, 11 Apr 2005 18:12:22 +0200
Message-Id: <1113235942.11475.547.camel@frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not subscribed, so this in not a real reply - sorry if it breaks
 threading somehow.]

Sven Luther wrote:
> The ftp-master are the ones reviewing the licencing problems, and they
are the
> ones handling the infrastructure, and putting their responsability on the
> stake. If they feel that some piece of software has dubious legal issues which
> come at a risk of having them personally come on the receiving end of a legal
> case, then they will say, no, we don't distribute this software, and that is
> the end of it.

I've been following the whole discussion (including later messages),
but I'm still missing one point. You seem to have investigated a lot 
on the subject, so I'll ask you. I don't get what real legal issues
distributors may have.

Let me explain with an example. Lets say:

A - is the Author (or rights owner) of the software (GPL'ed);
B - is an user, who got the a copy of the software from A;
C - is another user, who got a copy indirectly, that is from a  
    distributor;
D - is the distributor C got the copy from.
 
Now, IANAL at all. But it seems to me that B has the right to _use_ the
software by means of GPL. As long as A thinks B doesn't break GPL, B is
fine. All B needs to do is to fulfill GPL conditions (as a user, there's
little to do).

C also has the right to use the software, in a very similar way. As long
as A thinks C doesn't break GPL, C is fine.

D has the right to distribute the software, under GPL terms. As long as
A thinks D doesn't break GPL, D is fine.

Now. It seems to me that the relationship between D (distributor) and C
(target of the distribution) is _not_ regulated by GPL at all. GPL is a
license, the _owner_ of the rights (A) and the recipient of some rights
(C, as an user) are the only subjects. D _owns_ no rights on the
software, so can't grant any to C. There's no GPL between D and C.

So, even if C comes to think D is breaking GPL, all C can do is notify
A. The GPL D is supposedly breaking is an agreement between A and D
only. On which basis may C sue D? For breaking what agreement? It's up
to A to sue D for breaking GPL.

What is the risk for D, if D is distributing the source of the software
_exactly_ in the form A publicly provides it? It's not up to D to
produce the source, all D has to do is to provide verbatim copies of
it to anyone D distributes the software to, on request.

Does is really matter if C thinks the source being incomplete,
or missing? C can take the issue up with A (by means of the GPL that
exists between A and C), but not with D, since there's no GPL between
D and C. C is in the same position of B. If the source is incomplete,
they may ask A to comply to the GPL, but not D. D made no promises to
them.  

So, as long as they don't modify the source, distributors are safe.
No one can ask them to provide the "right" source, but A. And "right"
means "right for A", of course, when it's A asking, by definition.

What am I missing?

TIA,
.TM.

