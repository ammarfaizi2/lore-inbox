Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752146AbWIXS6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbWIXS6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbWIXS6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:58:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58019 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752146AbWIXS6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:58:44 -0400
Date: Sun, 24 Sep 2006 20:51:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060924185100.GA20524@elte.hu>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I think the "big merges in the first two weeks, and a -rc1 after, and 
> no new code after that" rule has been working because it brought 
> everybody in on the same page.

yeah. I dont really support the even/odd release thing because even the 
old 1.2/1.3/2.0/2.1/2.2/2.3/2.4 scheme _always_ confused non-insiders. 
Sometimes i saw it confuse people who already understood the GPL ;-) 
Furthermore it would just dillute our version numbers to encode some 
information that "-rc1" indicates just as well. Insiders know perfectly 
well that when -rc1 is released the merge window is closed. And what 
causes -rc elongation is usually not the lack of communication towards 
users or lack of testing but the lack of fixing power ...

	Ingo
