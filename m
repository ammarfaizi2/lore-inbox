Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265818AbUBBWbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbUBBWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 17:31:11 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:21455 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S265818AbUBBWbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 17:31:08 -0500
Date: Mon, 2 Feb 2004 16:31:07 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Getting an Infiniband access layer in the linux kernel
Message-ID: <20040202223107.GA27125@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 10gigabit ethernet drivers in the kernel.org 2.6, but no
infiniband drivers. Infiniband cards are faster, AND cheaper than 10gig
hardware right now, so this makes no sense.

Has anyone gotten on linux-kernel and asked about what it would take to
get the infiniband access layer into the kernel? (Once that's there we
could *start* talking about IPOIB, and such)

The first, and biggest problem is the access layer is of little use
without a VPD, and since mellanox is the only game in town right now, we
need mellanox to release a VPD that's GPL-compatible. This is mellanox's
problem, so we can't really do anything but tell them to hurry up.

Second is extracting the code into smaller digestible chunks that people
aren't going to scream over. So, can someone tell me how to extract just
the access layer out of the infiniband.bkbits.net tree? I'd like just
enough to be able to run something like NetPIPE on the intel verbs
layer.

And can someone from lkml please respond with suggestions on what would
have a chance of getting blessed with the appropriate penguin-pee?



-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@hozed.org  

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz
