Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261603AbSJNMPp>; Mon, 14 Oct 2002 08:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbSJNMPp>; Mon, 14 Oct 2002 08:15:45 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:41697 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261603AbSJNMPn>;
	Mon, 14 Oct 2002 08:15:43 -0400
Date: Mon, 14 Oct 2002 13:22:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Radez <rob@osinvestor.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021014122239.GA29240@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014101209.A18123@medelec.uia.ac.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:12:09AM +0200, Wim Van Sebroeck wrote:
 > Hi Rob,
 > 
 > I have downloaded your latest patch and will use it to update the watchdog 
 > drivers. I'll be doing some additional cleanup and additions myself probably.
 > 
 > Now I'm still left with my original question: wouldn't it be easier if we
 > put all watchdog drivers in drivers/char/watchdog/ ?

I'd say go for it. drivers/char/ is looking quite cluttered, and this
has the added advantage of decreasing the size of the Config.in and
config.help files too.

One thing though, please do the move first, and submit that, then do the
cleanups and submit seperatly. It makes things much easier to track
whats going on.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
