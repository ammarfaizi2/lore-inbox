Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTLGWLC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 17:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLGWLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 17:11:01 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2785 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S264535AbTLGWK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:10:58 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Sun, 7 Dec 2003 16:11:05 -0600
User-Agent: KMail/1.5
Cc: Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <Pine.LNX.4.58.0312051949210.2092@home.osdl.org> <Pine.LNX.4.58.0312071342150.25215@earth>
In-Reply-To: <Pine.LNX.4.58.0312071342150.25215@earth>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312071611.05273.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 07:01, Ingo Molnar wrote:
> On Fri, 5 Dec 2003, Linus Torvalds wrote:
> > In other words, if (b) is GPL-only, then you can't use (b) with (c),
> > _or_ C has to accept the GPL. "Forcing" a (b+c) doesn't make (c) be
> > under the GPL. But forcing (b+c) is illegal, since you can't force a
> > license without the agreement of the owner.
>
> i'm wondering why it's layed out like this. Couldnt the FSF have extended
> section 6 of the GPL the following way:
>
> ORIGINAL:  6. Each time you redistribute the Program (or any work based on
> the Program), the recipient automatically receives a license from the
> original licensor to copy, distribute or modify the Program subject to
> these terms and conditions. You may not impose any further restrictions on
> the recipients' exercise of the rights granted herein.
>
> [this section is a pure expression of a license from the original author,
> covering the original Program only - not the derivative.]
>
> ADDITION:  Each time you redistribute the Program (or any work based on
> the Program), the recipient automatically receives a license from you to
> copy, distribute or modify those portions ot the Program (or any work
> based on the Program), where you are the copyright owner or sublicensor.
> Any existing or future contract or agreement restricting you from doing so
> automatically terminates your rights under this License.

The GPL really needs an improved clause about patent licensing too.  (The GPL 
could easily be a patent pool.  Right now the language says that patents must 
be licensed for use by everybody, when all it really NEEDS to say is that the 
patent needs to be licensed for use in GPL programs.  in regards to patents, 
the GPL acts like the BSD license, rather than copyleft, and that would be 
really easy to fix.)

The GPL is sort of becoming a patent pool anyway, with Red Hat licensing its 
patents for use in GPL programs only, and IBM making noises about that, 
etc...  But it's not explicit, and it's not really one pool that you join 
automatically by participating, and that violation of the GPL could block you 
from access to all of...

Richard Stallman, unfortunately, is a zealot.  He wants to log roll a whole 
bunch of things like addressing the application service provider issue into a 
GPL 3.0, which means there probably never will be a GPL 3.0.  And he won't 
issue a GPL 2.1 with minor issues like these because that would erode the 
chocolate coating on the other unpopular issues he wants to lump together 
into a big "take it or leave it" upgrade at some nebulous point in the future 
that pushes unpopular elements of his agenda as part of the package...

Sad, really.  Oh well.  I suppose somebody could come out with a "GPL patent 
pool license", which might not violate the GPL.  The preamble says "we have 
made it clear that any patent must be licensed for everyone's free use or not 
licensed at all", but doesn't say who everyone is (since the license only 
applies to people who accept the license, then it could logically be 
"everyone who agrees to the GPL".)  Clauses 7 and 8 mention patents, but 
don't specify any license terms for them.  Therefore, you NEED a patent 
license, but the GPL doesn't give the text of it.

So if the GPL is just a copyright license, and it requires patents be licensed 
but doesn't specify the terms, therefore it's legal (and in fact expected) to 
combine the GPL with a (compatable) patent license.  But there IS no standard 
GPL patent license.  It would be nice if there was one, that could be 
regularly combined with the GPL in a standard way (GPL+), saying that the 
patents are licensed for use in GPL-licensed software only, as part of a GPL 
patent pool.

It's one way to bypass Stallman's log-rolling, anyway...

Rob
