Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTLGNBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTLGNBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:01:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10912 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264425AbTLGNBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:01:44 -0500
Date: Sun, 7 Dec 2003 14:01:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312051949210.2092@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312071342150.25215@earth>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
 <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com>
 <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com>
 <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com>
 <Pine.LNX.4.58.0312051949210.2092@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no, SpamAssassin (score=-4.9, required 5.9,
	BAYES_00 -4.90)
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Dec 2003, Linus Torvalds wrote:

> In other words, if (b) is GPL-only, then you can't use (b) with (c),
> _or_ C has to accept the GPL. "Forcing" a (b+c) doesn't make (c) be
> under the GPL. But forcing (b+c) is illegal, since you can't force a
> license without the agreement of the owner.

i'm wondering why it's layed out like this. Couldnt the FSF have extended
section 6 of the GPL the following way:

ORIGINAL:  6. Each time you redistribute the Program (or any work based on
the Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions. You may not impose any further restrictions on
the recipients' exercise of the rights granted herein.

[this section is a pure expression of a license from the original author,
covering the original Program only - not the derivative.]

ADDITION:  Each time you redistribute the Program (or any work based on
the Program), the recipient automatically receives a license from you to
copy, distribute or modify those portions ot the Program (or any work
based on the Program), where you are the copyright owner or sublicensor.  
Any existing or future contract or agreement restricting you from doing so
automatically terminates your rights under this License.

or something along these lines. Ie. cannot the act of distribution also
automatically trigger a license from the entity doing the redistribution,
for all portions which are owned by the redistributor? I suspect the FSF
would have done this if legally possible ... so there must be some major
roadblock in the way.

	Ingo
