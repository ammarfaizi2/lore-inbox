Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTI1QEs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTI1QEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:04:48 -0400
Received: from gprs149-123.eurotel.cz ([160.218.149.123]:50560 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262590AbTI1QEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:04:46 -0400
Date: Sun, 28 Sep 2003 18:04:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3 state
Message-ID: <20030928160421.GC204@elf.ucw.cz>
References: <20030927201420.GA415@elf.ucw.cz> <Pine.LNX.4.44.0309271638510.22923-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309271638510.22923-100000@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[Longer reply this time].

> > Patrick said he applied "revert" changes to his tree, but I can see
> > nothing in the mainline. This reverts swsusp to "-test3" state, and
> > makes it work here (*). Please apply,
> 
> No. 
> 
> I'm not going to apply warring patches. You two sort it out amonst 
> yourselves, I just don't care to be left in the middle.

I'm not playing patch wars, Patrick actually has very similar patch in
his tree already -- test5-pm2 contains kernel/sys.c and
kernel/power/swsusp.c changes; it does not contain
include/linux/suspend.h changes -- I'm not sure if that's mistake or
if prototypes were moved to some better place, and it does not contain
kernel/power/main.c changes -- main.c is pretty much rewritten in
test5-pm2 AFAICS so those changes do not apply.

> And yes, Pavel, that means you have to be civil. I was actually surprised 
> at how civil Pat was the last time around considering that there was a 
> longish thread where the subject was pretty negative about him. 

I hope to hear some comments from Patrick. He merged the code, but
does not seem to be pushing the changes. I'd like to have something at
least partly working in -test6.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
