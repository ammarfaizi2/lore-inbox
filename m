Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUG2Jtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUG2Jtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUG2Jtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:49:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53417 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267427AbUG2Jtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:49:40 -0400
Date: Thu, 29 Jul 2004 02:49:31 -0700
From: Paul Jackson <pj@sgi.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040729024931.4b4e78e6.pj@sgi.com>
In-Reply-To: <87oelzjhcx.fsf@ibmpc.myhome.or.jp>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
	<20040728231548.4edebd5b.pj@sgi.com>
	<87oelzjhcx.fsf@ibmpc.myhome.or.jp>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't see any big cleanup in your patch.

That could well be <grin>.  Beauty is in the eye of the beholder.

I figured that replacing the #define's with local variables
was worth a couple of style points, and that explicitly
checking that the user provided values were within limits,
all the time, no ifdefs, was more straight forward.

But it is difficult to establish such preferences with certainty.

Again, thanks for considering my reply.

Do as you think best.  I am afraid I have no more wisdom (if
ever I had any ...).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
