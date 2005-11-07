Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVKGRMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVKGRMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKGRMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:12:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:16306 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964854AbVKGRMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:12:03 -0500
Message-ID: <436F8ABE.9020605@nortel.com>
Date: Mon, 07 Nov 2005 11:11:26 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Eric Sandall <eric@sandall.us>, Willy Tarreau <willy@w.ods.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>	<12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>	<20051029195115.GD14039@flint.arm.linux.org.uk>	<Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>	<20051031064109.GO22601@alpha.home.local>	<Pine.LNX.4.63.0511062052590.24477@cerberus> <m3k6fkxwqe.fsf@defiant.localdomain>
In-Reply-To: <m3k6fkxwqe.fsf@defiant.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 17:11:28.0579 (UTC) FILETIME=[4AA8B930:01C5E3BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Eric Sandall <eric@sandall.us> writes:

>>A -final should never be changed from the last -rc. That defeats the
>>purpose of having -rc releases (rc == 'release candidate' ;)).
> 
> 
> This logic is flawed. RCs are for performing tests. If you don't want
> further tests (for example, tests on previous RC completed and you're
> quite sure new changes introduce no new bugs) you don't need further
> RCs.

How do you ever know that new change introduced no new bugs?  Maybe 
there was a latent race condition that is activated by timing 
differences caused by the new code.  Maybe it shifts the spacing of the 
code just enough to get hit by a pre-existing trampler.  Unless you test 
it, you *can't* know.

The safe bet is to simply rename the final -rc with no further changes.

Chris
