Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVCDC6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVCDC6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVCDCsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:48:43 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:48093 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262771AbVCCXm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:42:28 -0500
Date: Thu, 03 Mar 2005 18:42:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <42277C81.4010302@pobox.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503031842.23937.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
 <1109882043.4032.79.camel@tglx.tec.linutronix.de> <42277C81.4010302@pobox.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 March 2005 16:07, Jeff Garzik wrote:
>As a further elaboration...
>
>The problem with the current 2.6-rc setup is a _human_
> _communications_ problem.
>
>Users have been trained in a metaphor that is applied uniformly
> across all software projects that use the metaphor:
>
> test release:  a useful merge/testing point
> release candidate: bugfixes only, test test test
>
>Linux does it differently.
>
>It's hard enough to get users to test...   now we have raised the
>barrier even higher by abusing a common metaphor.  A metaphor that
> is used _succesfully_ elsewhere to get users to test.
>
>"release candidate" is a promise to users that the current tree is
> close to what the release will look like, and only major fixes will
> appear between -rc and -final.
>
>We broke that promise.  In human interface terms, this is like
>redefining the "garbage can" icon to mean "save your work."  ;-)
>
> Jeff

I've seen this comment before too, and I still think it says it best:

The full release s/b the last rc with NO changes other than its name.

Now we are faced with a final that may have another 50k+ of patches 
applied over what made the rc5.  IMO, in the immediately past case, 
that should not have been final, but an rc6.

I personally vote for going back to the -pre series where we get to 
test new ideas & maybe morph the neighbors dog/cat.  At some point it 
gets stable enough to call it -rc1, at which point nothing but 
bugfixes should be allowed in until the final.  That way we have a 
develop, then stabilize, then develop the next, then stabilize it set 
of stairsteps.

I personally build and run as many of them as I can find the time to 
do.  I just applied the bk-1394-patch and its building because 2.6.11 
isn't really comfortable running my movie camera yet.

I also haven't built any more of Andrews -mm's since the last time I 
got told off about it.  I can go back to doing that too, if the 
results of my testing it aren't going to be thrown out like the babys 
bath water.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
