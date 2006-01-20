Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWATRIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWATRIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWATRIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:08:55 -0500
Received: from b.relay.invitel.net ([62.77.203.4]:63107 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP
	id S1750839AbWATRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:08:54 -0500
Date: Fri, 20 Jan 2006 18:08:52 +0100
From: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120170851.GA11489@lgb.hu>
Reply-To: lgb@lgb.hu
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
X-Operating-System: vega Linux 2.6.12-10-686 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though I'm not a kernel developer let me allow to comment this based on
my experiences as well.

On Fri, Jan 20, 2006 at 08:17:40AM -0700, Michael Loftis wrote:
> OK, I don't know abotu others, but I'm starting to get sick of this 
> unstable stable kernel.  Either change the statements allover that were 

What kind of instability have you got? I haven't had any instability since
at least a year or so, or if there was it was some kind of hardware fault.
In fact, many machines (like an Armada E500 notebook and some servers as well)
seems to be stable which was NOT in case of 2.4 kernels! So for our experience
at our workplace, 2.6 seems to be much more usable than 2.4.x kernels (ok,
it may be caused by "newer" hardwares, on quite old machines I can't show
major difference in stability between 2.4 and 2.6)

> made that even-numbered kernels were going to be stable or open 2.7. 
> Removing devfs has profound effects on userland.  It's one thing to screw 
> with all of the embedded developers, nearly all kernel module developers, 
> etc, by changing internal APIs but this is completely out of hand.

It was marked as obsoleted for some time ... I guess marking something
'osboleted' means that _NO_ new project should depends on it, and also
existing projects should be ported to the newer solutions. The purpose of
this process is to leave enough time for developers to react. I can't see
any problem here. You would be right if devfs would have been removed some
day without any notice before.
 
> Normally I wouldn't care, and I'd just stay away from 'stable' until 
> someone finally figured out that a dev tree really is needed, but I can't 
> stay quiet anymore.  2.6.x is anything but stable right now.  It might be 
> stable in the sense that most any development kernel is stable in that it 
> runs without crashing, but it's not at all stable in the sense that 
> everything is changing as if it were an odd numbered dev tree.

Ah, I see your point. But is it really a BIG problem? I mean please mention
some *real* issue/story confirm your opinion. Sure, you can find, but also
compare it with the advantages of new development model, since there is nothing
in the world which is only have advantages neither something which only has
disadvantages ... The would is not black or white, but a great spectrum of
gray shades.

> Yes, I'm venting some frustrations here, but I can't be the only one.  I 
> know now I'm going to be called a troll or a naysayer but whatever.  The 
> fact is it needs saying.  I shouldn't have to do major changes to 
> accomodate sysfs in a *STABLE* kernel when going between point revs.  This 
> is just not how it's been done in the past.

sysfs should not used by an average application, I guess, so it's not a major
point

-- 
- Gábor
