Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTLEB6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTLEB6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:58:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:49111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263788AbTLEB6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:58:43 -0500
Date: Thu, 4 Dec 2003 17:58:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031205012124.GB15799@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312041750270.6638@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
 <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, Larry McVoy wrote:
> >
> > linux/COPYING says: This copyright does *not* cover user programs
> > that use kernel services by normal system calls - this is merely
> > considered normal use of the kernel, and does *not* fall under
> > the heading of "derived work".
>
> Yeah, and the GPL specificly invalidates that statement.  We're on thin
> ice here.  Linus is making up the rules, which is cool (since I tend to
> like his rules) but the reality is that the GPL doesn't allow you to
> extend the GPL.  It's the GPL or nothing.

Larry, you are wrong.

The license _IS_ the GPL. There's no issue about that. The GPL rules apply
100%.

But a license only covers what it _can_ cover - derived works. The fact
that Linux is under the GPL simply _cannot_matter_ to a user program, if
the author can show that the user program is not a derived work.

And the linux/COPYING addition is not an addition to the license itself
(indeed, it cannot be, since the GPL itself is a copyrighted work, and so
by copyright law you aren't allowed to just take it and change it).

No, the note at the top of the copying file is something totally
different: it's basically a statement to the effect that the copyright
holder recognizes that there are limits to a derived work, and spells out
one such limit that he would never contest in court.

See? It's neither a license nor a contract, but it actually does have
legal meaning: look up the legal meaning of "estoppel" (google "define:"
is qutie good). Trust me, it's got _tons_ of legal precedent.

		Linus
