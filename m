Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSGXPAI>; Wed, 24 Jul 2002 11:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGXPAH>; Wed, 24 Jul 2002 11:00:07 -0400
Received: from bitmover.com ([192.132.92.2]:20163 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S317314AbSGXPAH>;
	Wed, 24 Jul 2002 11:00:07 -0400
Date: Wed, 24 Jul 2002 08:03:13 -0700
From: Larry McVoy <lm@bitmover.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Alex Riesen <Alexander.Riesen@synopsys.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 (linus' bk): conflicting KEY_xxx macros
Message-ID: <20020724080313.J27617@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thunder from the hill <thunder@ngforever.de>,
	Alex Riesen <Alexander.Riesen@synopsys.com>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <20020724144804.GE14143@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.44.0207240854590.3472-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207240854590.3472-100000@hawkeye.luckynet.adm>; from thunder@ngforever.de on Wed, Jul 24, 2002 at 08:57:09AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I poked around at this with revtool trying to figure out what the intent
was.  It seems like the keys were all decimal, then at 0x100 it switched
to BTN_*, then on Jul 13 Vojtech added a change for settop boxes which
used the 0x160 .. range for more KEY_*.  For whatever that is worth.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
