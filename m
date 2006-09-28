Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWI1Ol1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWI1Ol1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWI1Ol1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:41:27 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:20143 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161149AbWI1Ol0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:41:26 -0400
Date: Thu, 28 Sep 2006 16:40:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Linus Torvalds <torvalds@osdl.org>,
       Patrick McFarland <diablod3@gmail.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060928144028.GA21814@wohnheim.fh-wedel.de>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca> <20060928141932.GA707@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928141932.GA707@DervishD>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 September 2006 16:19:32 +0200, DervishD wrote:
> 
>     Probably the renaming is just common sense and will avoid ALL
> problems. People like me are concerned only because all GPLv2 that
> doesn't state otherwise will be released automagically under GPLv3 as
> soon as the latest draft is made the official version. Otherwise, I
> wouldn't give a hump about any new license until I have the time to
> read it and see if I like it.

In my very uninformed opinion, your problem is a very minor one.  Your
"v2 or later" code won't get the license v2 removed, it will become
dual "v2 or v3" licensed.  And assuming that v3 only adds restrictions
and doesn't allow the licensee any additional rights, you, as the
author, shouldn't have to worry much.

The problem arises later.  As with BSD/GPL dual licensed code, where
anyone can take the code and relicense it as either BSD or GPL, "v2 or
v3" code can get relicensed as v3 only.  At this point, nothing is
lost, as the identical "v2 or v3" code still exists.  But with further
development on the "v3 only" branch, you have a fork.  And one that
doesn't just require technical means to get merged back, but has legal
restrictions.

And I assume (careful, I'm _really_ uninformed here) the FSF is well
aware of that and wants a one-way compatibility between v2 and v3.
Any v2 code can be picked up by a v3 project, but not the other way
around.  v3 projects have a clear evolutionary advantage over v2.

And here the kernel wording with "v2 only" in the kernel is
interesting.  It turns a one-way compatibility into no compatibility
at all.  So the evolutionary advantage is lost, as it only exists
through the "v2 or later" term.

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
