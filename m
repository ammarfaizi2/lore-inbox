Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbSJaXr0>; Thu, 31 Oct 2002 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265522AbSJaXpw>; Thu, 31 Oct 2002 18:45:52 -0500
Received: from dp.samba.org ([66.70.73.150]:62150 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265525AbSJaXpp>;
	Thu, 31 Oct 2002 18:45:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over. 
In-reply-to: Your message of "Thu, 31 Oct 2002 13:10:07 CDT."
             <3DC171FF.5000803@nortelnetworks.com> 
Date: Fri, 01 Nov 2002 08:33:18 +1100
Message-Id: <20021031235212.01EB92C147@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DC171FF.5000803@nortelnetworks.com> you write:
> Ideally I would like to see a dump framework that can have a number of 
> possible dump targets.  We should be able to dump to any combination of 
> network, serial, disk, flash, unused ram that isn't wiped over restarts, 
> etc...

Both the lkcd and ide mini-oopser have that (although the mini-oopser
has only x86-ide for now).

The mini-oopser has different aims than LCKD: they want to debug one
system, I want to make sure we're reaping OOPS reports from those 99%
of desktop users who run X and simply reboot when their machine
crashes once a month.

I did *not* put the mini-oopser on the Snowball list, because I don't
have time to polish it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
