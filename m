Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWI1PEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWI1PEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWI1PEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:04:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751908AbWI1PEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:04:39 -0400
Date: Thu, 28 Sep 2006 08:04:13 -0700 (PDT)
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
In-Reply-To: <20060928144028.GA21814@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
 <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-694347448-1159455853=:3952"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-694347448-1159455853=:3952
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 28 Sep 2006, Jörn Engel wrote:
> 
> And I assume (careful, I'm _really_ uninformed here) the FSF is well
> aware of that and wants a one-way compatibility between v2 and v3.
> Any v2 code can be picked up by a v3 project, but not the other way
> around.  v3 projects have a clear evolutionary advantage over v2.

A _real_ v2 project doesn't have that problem. In fact, I'm a huge 
believer in evolution (not in the sense that "it happened" - anybody who 
doesn't believe that is either uninformed or crazy, but in the sense "the 
processes of evolution are really fundamental, and should probably be at 
least _thought_ about in pretty much any context").

And I think the v2 is actually _more_ stable in an evolutionary sense 
(look up Maynard Smith and "ESS" - "Evolutionarily Stable Strategy" - for 
more ideas about the biological evolution case) exactly because it's more 
inclusive - it handles more cases.

The GPLv3 is a dead end in some areas, exactly because it limits how the 
project can be used, and as such will automatically limit itself away from 
some niches. Also, because I believe that it's less "universally 
acceptable", it has a harder time competing anyway.

And the GPLv2 and GPLv3 really _are_ mutually incompatible. There is 
absolutely nothing in the GPLv2 that is inherently compatible with the 
GPLv3, and the _only_ way you can mix code is if you explicitly 
dual-license it.

Ie, GPLv2 and GPLv3 are compatible only the same way GPLv2 is compatible 
with a commercial proprietary license: they are compatible only if you 
release the code under a dual license. 

The whole "or later" phrase is legally _no_ different at all from a dual 
licensing (it's just more open-ended, and you don't know what the "or 
later" will be, so you're basically saying that you trust the FSF 
implicitly).

> And here the kernel wording with "v2 only" in the kernel is
> interesting.

No. I _really_ want to clarify this, because so many people get it wrong. 
Really.

The "GPLv2 only" wording is really just a clarification. You don't need it 
for the project to be "GPLv2 only".

If a project says: "This code is licensed under this copyright license" 
and then goes on to quote the GPLv2, then IT IS NOT COMPATIBLE WITH THE 
GPLv3!

Or if you just say "I license my code under the GPLv2", IT IS NOT 
COMPATIBLE WITH THE GPLv3.

Really. There is zero inherent compatibility. The GPLv2 is written (on 
purpose) to not be compatible with _anything_ but itself. If you want your 
code to be compatible with anything else, you have to explicitly say so. 
In other words, you have to dual-license it, and _keep_ it dual-licensed.

> So the evolutionary advantage is lost, as it only exists through the "v2 
> or later" term.

Exactly. The GPLv3 can _only_ take over a GPLv2 project if the "or later" 
exists.

It should also be pointed out that even a "GPLv2 or later" project can be 
forked two different ways: you can turn it into a "GPLv3" (with perhaps a 
"or later" added too) project, but you can _equally_ turn it into a "GPLv2 
only" project.

In other words, even if the license says "GPLv2 or later", the GPLv3 isn't 
actually "stronger". The original author dual-licensed it, and expressly 
told you that he's ok with any GPL version greater than or equal to 2.

			Linus
--21872808-694347448-1159455853=:3952--
