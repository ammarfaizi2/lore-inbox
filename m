Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWIXWiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWIXWiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIXWiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:38:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46278 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751380AbWIXWiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:38:04 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45170805.6010409@s5r6.in-berlin.de>
Date: Mon, 25 Sep 2006 00:34:45 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>	<45130533.2010209@tmr.com>	<45130527.1000302@garzik.org>	<20060921.145208.26283973.davem@davemloft.net>	<20060921220539.GL26683@redhat.com>	<20060922083542.GA4246@flint.arm.linux.org.uk>	<20060922154816.GA15032@redhat.com>	<Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>	<20060924074837.GB13487@xi.wantstofly.org>	<20060924092010.GC17639@flint.arm.linux.org.uk> <BAYC1-PASMTP025A69D18D30F23AC048BDAE270@CEZ.ICE>
In-Reply-To: <BAYC1-PASMTP025A69D18D30F23AC048BDAE270@CEZ.ICE>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:
> On Sun, 24 Sep 2006 10:20:10 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
>> The point I'm making is that for some things, keeping the changes as
>> patches until they're ready is far easier, more worthwhile and flexible
>> than having them simmering in some git tree somewhere.
> 
> It's not really easier, just different.   Git allows you to make a 
> "topic branch" to keep separate items that need to bake before going
> upstream without being mixed in with all your other worked.
...
> Git _does_ make it easy and practical to do the same thing.

I'm not convinced. Certain workflows are more focused on how changes
change (sic) rather than on how the end product i.e. the sources change.
I am referring to reworking of patches during tests and reviews as well
as rewriting descriptions, collecting Acks and Sign-offs etc. while
maintaining a certain identity of the patch or series of patches.

But maybe I'm just not aware of how git may support this effectively.
Perhaps thusly: Let the young and wild times of life of a patch actually
result into many commits to a topic branch; collapse a lot of these
commits into one or few diffs for each review round; move to a new topic
branch for bigger reworks of the changeset; and finally collapse it into
one or few commits to a staging branch for submission? Sounds still more
like a job for patch-centered tools like quilt.
-- 
Stefan Richter
-=====-=-==- =--= ==---
http://arcgraph.de/sr/
