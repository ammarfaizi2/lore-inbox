Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSG0EQW>; Sat, 27 Jul 2002 00:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSG0EQW>; Sat, 27 Jul 2002 00:16:22 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:59584 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316210AbSG0EQV>;
	Sat, 27 Jul 2002 00:16:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kiran <geekazoid@phreaker.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines 
In-reply-to: Your message of "Fri, 26 Jul 2002 14:53:44 +0530."
             <20020726145344.A18568@phreaker.net> 
Date: Sat, 27 Jul 2002 14:17:30 +1000
Message-Id: <20020727042035.5AA0B413A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020726145344.A18568@phreaker.net> you write:
> On Fri, Jul 26, 2002 at 05:56:19PM +1000, Rusty Russell wrote:
> > While it's probably justified in this case, you pay for it in a slight
> > increase in size...
> 
> I thought you were of the opinion that "memory is cheap" ;-)

Absolutely: if you're trading it for programming time.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
