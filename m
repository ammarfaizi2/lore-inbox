Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSGXRpn>; Wed, 24 Jul 2002 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSGXRpn>; Wed, 24 Jul 2002 13:45:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22688 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317443AbSGXRpm>;
	Wed, 24 Jul 2002 13:45:42 -0400
Date: Wed, 24 Jul 2002 19:48:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>,
       Thunder from the hill <thunder@ngforever.de>,
       Alex Riesen <Alexander.Riesen@synopsys.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 (linus' bk): conflicting KEY_xxx macros
Message-ID: <20020724194823.D2672@ucw.cz>
References: <20020724144804.GE14143@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.44.0207240854590.3472-100000@hawkeye.luckynet.adm> <20020724080313.J27617@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020724080313.J27617@work.bitmover.com>; from lm@bitmover.com on Wed, Jul 24, 2002 at 08:03:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 08:03:13AM -0700, Larry McVoy wrote:

> I poked around at this with revtool trying to figure out what the intent
> was.  It seems like the keys were all decimal, then at 0x100 it switched
> to BTN_*, then on Jul 13 Vojtech added a change for settop boxes which
> used the 0x160 .. range for more KEY_*.  For whatever that is worth.

Yes, and I didn't review the change well enough and didn't see the
conflicting definitions. In the next update they're OK again, but that
hasn't made it into Linus's kernel yet.

-- 
Vojtech Pavlik
SuSE Labs
