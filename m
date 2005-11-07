Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVKGSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVKGSZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVKGSZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:25:41 -0500
Received: from khc.piap.pl ([195.187.100.11]:11268 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964881AbVKGSZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:25:40 -0500
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: Eric Sandall <eric@sandall.us>, Willy Tarreau <willy@w.ods.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
	<20051029195115.GD14039@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
	<20051031064109.GO22601@alpha.home.local>
	<Pine.LNX.4.63.0511062052590.24477@cerberus>
	<m3k6fkxwqe.fsf@defiant.localdomain> <436F8ABE.9020605@nortel.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 07 Nov 2005 19:25:35 +0100
In-Reply-To: <436F8ABE.9020605@nortel.com> (Christopher Friesen's message of
 "Mon, 07 Nov 2005 11:11:26 -0600")
Message-ID: <m3ll00wc0w.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortel.com> writes:

> How do you ever know that new change introduced no new bugs?

Changing comments doesn't change generated code or your tools are
screwed. Trivial changes - you can be reasonably sure, too. Note
it's different from not having bugs at all.

>  Maybe
> there was a latent race condition that is activated by timing
> differences caused by the new code.

Then the bug already existed, you aren't adding any.

> The safe bet is to simply rename the final -rc with no further changes.

Safe? You can't be really safe here. Bad luck and version string
change (compile time or -rc* removal) will trigger disaster.
-- 
Krzysztof Halasa
