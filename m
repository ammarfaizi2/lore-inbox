Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTFNUm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbTFNUmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:42:45 -0400
Received: from ishtar.tlinx.org ([64.81.58.33]:17341 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S265710AbTFNUlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:41:39 -0400
From: "linda w." <linux-newbie@tlinx.org>
To: "'Kari Hurtta'" <hurtta+z1@leija.mh.fmi.fi>
Cc: <linux-newbie@vger.kernel.org>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: reading links in proc - permission denied
Date: Sat, 14 Jun 2003 13:55:21 -0700
Message-ID: <000b01c332b7$44c68250$1403a8c0@sc.tlinx.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200306141905.h5EJ57mE024740@leija.fmi.fi>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: hurtta@leija.mh.fmi.fi [mailto:hurtta@leija.mh.fmi.fi]
> Are you sure that 'top' uses that 'exe' ?
---
	Not at all...in fact was told it doesn't.  Apparently, though,
the listed permissions on the links are arbitrary and the system
fairly well ignores them.

	I vaguely remember someone once saying that even if a symlink
had permissions lrxw------, it could still be used by group and
others.  I don't know if that was or is still true -- certainly doesn't
seem consistent, but when dealing with computer systems made by
many different humans, inconsistency seems inevitable -- even when
made by 1 human, that person can be inconsistent over time.

	And people wonder why computer security is so hard to 'get right'.

The general attitude is often that 'it is the way that it is, and unless
it is causing a current problem', don't fix it.  In companies -- it
translates to "if it's not a customer reported bug, or performance problem
or feature request", then it's not a priority.  And even when customers
do talk, it depends on the $$$ represented by the customers and the $$$
it will take to fix it.  Cold hard cash.  Perfect capitalistic system
that guarantees security problems won't be fixed until they are
published and/or exploited on enough victims's to add up to $$$'s worth
of business it will cost to fix the bug.

	Even Common Criteria evaluations are run simililarly.  To my knowledge
(and correct me if I am wrong, please! -- http pointers wanted!):

1) there is no requirement for a vendor to report known bugs to
	the third-party evaluation teams or the customers as long as the bug
	is only in internal company databases.

2) Testplans for a product to pass an evaluation as well as the tests
	themselves are created and approved by the third party evaluation
team.
	So, for example:

	a) if you can create a test plan that doesn't test a
	known problem area and the certifier approves the plan, that's
	perfectly legal and going by the system.

	b) if you have to test a problematic area and can create a test that
	avoids the problem, and the Cert. approves the tests as following the
	test plan, that's also legal and going by the system.

	c) if you can't avoid writing a test that will show up the plan, you
	can write the test to be extremely difficult to run and to hide
	the resulting failure -- like requiring a complete system reinstall
	both before and after the test is run.  That way, if a test
	compromises security for later program execution, it won't be
	uncovered since the test plan required an immediate reboot after
	test was run (thus hiding the now compromised system state).  And
again,
	it would appear this is perfectly legal, and following the letter of
	the law as defined by the evaluation system.

3) Only bugs that become publicly known and/or to the end customer need to be
	fixed.

	It seems this is standard practice for the world - accepted CC
security
rating system as I last understood it and as it was last explained to me.

	Now this is for government level security-evaluated systems recognized
in Euro-American (US & Canada) and several other systems.

	The requirements for consumer products, of course, as in the
non-binding click-through license agreement many customers believe in, are
less stringent than the above -- test plan?  What's a test plan -- oh yeah,
that's shipping the product to be tested to 'alpha and beta' sites and see
what turns up.

	Even at the level of formal government security evaluations, there
seem to be loopholes large enough to steer the QE-II through.

	If anyone knows information opposite to the above, please let me know.
	It's pathetic enough now that standard practice with consumer programs
is to ship with little or no testing, then require the consumers to pay
money for each bug they want fixed (via time or (increasingly common) per
incident) fix.

	It's always rubbed me the wrong way to have a company sell me a fault
product, then I have to pay them a 2nd time to fix a bug they put in
the first time.  How do I know that bugs aren't being deliberately planted
to bring in more service revenue -- which can far exceed the cost of the
original product.

-linda



