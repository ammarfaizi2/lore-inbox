Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWIXXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWIXXIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWIXXID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 19:08:03 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:39989 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751323AbWIXXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 19:08:01 -0400
Message-ID: <BAYC1-PASMTP037F84364CAAD92F9D37E8AE270@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sun, 24 Sep 2006 19:07:58 -0400
From: Sean <seanlkml@sympatico.ca>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Lennert Buytenhek <buytenh@wantstofly.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060924190758.132c0008.seanlkml@sympatico.ca>
In-Reply-To: <45170805.6010409@s5r6.in-berlin.de>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<45130533.2010209@tmr.com>
	<45130527.1000302@garzik.org>
	<20060921.145208.26283973.davem@davemloft.net>
	<20060921220539.GL26683@redhat.com>
	<20060922083542.GA4246@flint.arm.linux.org.uk>
	<20060922154816.GA15032@redhat.com>
	<Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
	<20060924074837.GB13487@xi.wantstofly.org>
	<20060924092010.GC17639@flint.arm.linux.org.uk>
	<BAYC1-PASMTP025A69D18D30F23AC048BDAE270@CEZ.ICE>
	<45170805.6010409@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2006 23:08:00.0205 (UTC) FILETIME=[47A98FD0:01C6E02E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 00:34:45 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> I'm not convinced. Certain workflows are more focused on how changes
> change (sic) rather than on how the end product i.e. the sources change.
> I am referring to reworking of patches during tests and reviews as well
> as rewriting descriptions, collecting Acks and Sign-offs etc. while
> maintaining a certain identity of the patch or series of patches.
> 
> But maybe I'm just not aware of how git may support this effectively.
> Perhaps thusly: Let the young and wild times of life of a patch actually
> result into many commits to a topic branch; collapse a lot of these
> commits into one or few diffs for each review round; move to a new topic
> branch for bigger reworks of the changeset; and finally collapse it into
> one or few commits to a staging branch for submission? Sounds still more
> like a job for patch-centered tools like quilt.

Well, you're absolutely right about native Git being more focused on
tracking the final product.  However, there are tools growing up around
Git that attempt to give similar (although completely integrated with
Git) functionality of Quilt.  One such tool is Stacked Git (StGit)
http://www.procode.org/stgit/.  Since i'm not actually a user myself,
I can't vouch for it, but it does have a responsive community around it
and seems to be providing what it set out to accomplish.

Sean
