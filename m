Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbTLFVTG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLFVTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:19:06 -0500
Received: from thunk.org ([140.239.227.29]:46546 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265246AbTLFVTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:19:02 -0500
Date: Sat, 6 Dec 2003 16:19:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206211900.GA9034@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <20031206141300.GA13372@pimlott.net> <20031206175041.GD28765@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206175041.GD28765@work.bitmover.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 09:50:41AM -0800, Larry McVoy wrote:
> The sticky one is the one where we started, kernel modules.  Linus is
> saying that kernel modules are covered by the GPL because they are
> combined with the kernel.  I think his reasoning is weak and unlikely
> to be upheld by the courts.  If we remove the issue of inline functions
> for a moment then we are talking about pure API's and there is no way
> that the courts are going to uphold that a copyright license can cross a
> pure API (famous last words).  Well, no way if both sides of the dispute
> have equally good lawyers, without that who knows.  

I had a law professor from the MIT Sloan School of Technology, who
when I posed the question informally, said that the FSF would be
laughed out of court if they tried to claim that the GPL infected
across API's.  But Larry's right, in the U.S. at least, you get the
best justice money can buy, and with enough high-paid lawyers and
lobbyist, you can probably pervert the system any way you like ---
witness the RIAA and DMCA.

But that aside, does the Open Source community really want to push for
the legal principal that just because you write an independent program
which uses a particular API, the license infects across the interface?
That's essentially interface copyrights, and if say the FSF were to
file an amicus curiae brief support that particular legal principle in
an kernel modules case, it's worthwhile to think about how Microsoft
and Apple could use that case law to f*ck us over very badly.  

It would mean that we would not be able to use Microsoft DLL's in
programs like xine.  It would mean that programs like Crossover office
wouldn't work.  It would mean that Apple could legally prohibit people
from writing enhancements to MacOS (for example, how do all of the
various extensions in Mac OS 9 work?  They link into the operating
system and modify its behaviour.  If they are therefore a derived work
of MacOS, then Apple could screw over all of the people who write
system extensions of MacOS.)  

Be careful of what you wish for, before you get it.  The ramifications
of the statement that just because a device driver is written for
Linux, that it is presumptively a derived work of Linux unless proven
otherwise, is amazingly scary.  Fortunately, we can hope that the law
professor I talked to was right, and that such a claim would be
laughed out of court.  But if it isn't, look to Microsoft and other
unsavory companies to use that kind of case law to completely screw us
to the wall.....

						- Ted
