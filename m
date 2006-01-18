Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWARUGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWARUGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWARUGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:06:55 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:18707 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030277AbWARUGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:06:54 -0500
Date: Wed, 18 Jan 2006 15:06:20 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jbenc@suse.cz, softmac-dev@sipsolutions.net,
       bcm43xx-dev@lists.berlios.de
Subject: wireless: the contenders
Message-ID: <20060118200616.GC6583@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jbenc@suse.cz, softmac-dev@sipsolutions.net,
	bcm43xx-dev@lists.berlios.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, the news everyone will like.  Thanks to the kernel.org team
I now have a place to publish a wireless tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git

The tree there has a number of branches, so many that you need
a scorecard...

Branches
--------

The "master" branch of that tree is (mostly) up-to-date w/ Linus, plus
changes I recently sent to Jeff.  Those changes are also available on
the "upstream-jgarzik" branch, but it is frozen to when I requested
Jeff's pull.

The tree also has "softmac" and "dscape" branches.  The "softmac"
branch includes the Johannes Berg softmac code as well as the the
BCM43xx driver based upon that code.  The "dscape" branch includes
the DeviceScape patches from Jiri Benc as well as the BCM43xx driver
ported to the DeviceScape stack.

The fact that the BCM43xx team has ported their driver to both stacks
provides us an excellent opportunity for some objective, "apples to
apples" comparisons between the major stacks.  I would like to take
this opportunity to thank them for taking the trouble to do that work
and to make both versions available for comparison.

BTW, those trying to actually use the dscape code will want to poke
around Jiri's kernel.org directories:

   http://www.kernel.org/pub/linux/kernel/people/jbenc/

Jiri has some information there that will likely be useful to you.

The other branches are for administrative purposes, and can mostly
be ignored.

Patches
-------

Along with bugfixes and enhancements to the current code (which will
be targeting the "master" branch), I would like to see driver and
stack patches for both the "softmac" and "dscape" branches.  I would
like to see what is really out there before making a final call on
which stack to adopt permanently.

If you have an out-of-tree driver which targets either (or both)
stacks, please send patches.  If you are working on porting an
in-kernel driver to one of these stacks (either from the other stack
or from its private stack), please send patches.  If you have fixes
or enhancements pending for either of these stacks, then please
send patches.

Don't waste any time with your patches.  There is good reason to make
a decision quickly, and plenty of pressure to do so.  Your code could
be a significant factor in making that decision.

I know that many of you believe that this approach is a bad idea,
for a variety of reasons.  I find those arguments valid, and
even persuasive.  The point of this exercise is NOT to push two
stacks forward into Linus' kernel.  The point is to catalog the
true state of affairs and to collect as large a wireless driver
codebase as possible.  You might think of this as a Domesday Book
(http://en.wikipedia.org/wiki/Domesday_Book) for Linux wireless.

Summary
-------

Hopefully the act of collecting these patches will also allow the less
motivated among us to have a chance to evaluate the stacks involved.
There are bound to be some wise and skilled kernel hackers out there
that are just a little too busy to track-down all these patches
themselves...  :-)

I appreciate all the commentary and ideas expressed over the past
couple of weeks.  I also think the driver writers are doing a good
job with what they've been given so far.  I hope this helps to bring
the driver guys in out of the cold, and to put some weight behind
the discussions of where we need to go.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
