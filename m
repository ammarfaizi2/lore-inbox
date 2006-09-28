Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWI1PYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWI1PYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWI1PYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:24:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030187AbWI1PYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:24:47 -0400
Date: Thu, 28 Sep 2006 08:24:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609280808450.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
 <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Sep 2006, Linus Torvalds wrote:
> 
> It should also be pointed out that even a "GPLv2 or later" project can be 
> forked two different ways: you can turn it into a "GPLv3" (with perhaps a 
> "or later" added too) project, but you can _equally_ turn it into a "GPLv2 
> only" project.

Btw, it should be stated here: I'm not advocating either of the above. If 
a license says "v2 or later", anybody who removes an explicit right 
granted by the people who originally wrote and worked on the code is just 
being a total a-hole.

Quite frankly, if the FSF ever relicenses any of their projects to be 
"GPLv3 or later", I will hope that everybody immediately forks, and 
creates a GPLv2-only copy (and yes, you have to do it immediately, or 
you're screwed forever). That way the people involved can all vote with 
their feet.

I think the same is true of code that is licensed "GPL or BSD dual 
licensed". If I notice a patch that removes the BSD dual-license for a 
file, I won't apply it to the kernel I maintain unless there is some 
really pressing reason that I can't even think of off-hand (of course, 
that doesn't mean it can't have happened - if it came through a 
sub-maintainer I would likely never even have noticed).

Or, indeed, as in the case of the reiserfs code: it's dual-licensed "GPLv2 
or any other license as per Hans Reiser".

Btw, I have always found it funny how some people have no problem at all 
with "GPLv2 or later", but then complain about reiserfs: it is _exactly_ 
the same dual-license, it's just that a different legal entity controls 
the other yet-to-be-determined license.

The only _real_ difference is that in the case of reiserfs, the "other 
entity" is actually the original author of the code, so I _personally_ 
actually very strongly feel that the reiserfs case is _better_ than "GPLv2 
or later". In the reiserfs case, the person who does the relicensing is 
actually the same people who wrote the original code and maintained it. 

That's how it should be (of course, I think Reiser isn't actually 
actively maintaining reiserfs any more, so at some point his "moral 
rights" do end up weakening, but in the absense of any big rewrites, I 
don't think that has happened yet in this example - I just wanted to 
point out that things aren't "black-and-white" and "original author" 
only gets you so far if you then leave the project).

I know certain people don't like the reiserfs license - they've complained 
to me. At the same time, I know some of those same people themselves 
expressly use "GPLv2 or later". I think those people have a serious 
disconnect in their logic.

			Linus
