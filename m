Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJNM5X>; Mon, 14 Oct 2002 08:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSJNM5X>; Mon, 14 Oct 2002 08:57:23 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:11490 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261614AbSJNM5W>;
	Mon, 14 Oct 2002 08:57:22 -0400
Date: Mon, 14 Oct 2002 14:04:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Rob Radez <rob@osinvestor.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021014130441.GA528@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be> <20021014122239.GA29240@suse.de> <20021014144158.A19209@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021014144158.A19209@medelec.uia.ac.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 02:41:58PM +0200, Wim Van Sebroeck wrote:
 > On Mon, Oct 14, 2002 at 01:22:39PM +0100, Dave Jones wrote:
 > 
 > >  > Now I'm still left with my original question: wouldn't it be easier if we
 > >  > put all watchdog drivers in drivers/char/watchdog/ ?
 > > 
 > > I'd say go for it. drivers/char/ is looking quite cluttered, and this
 > > has the added advantage of decreasing the size of the Config.in and
 > > config.help files too.
 > 
 > I still see two options:
 > 1) drivers/char/watchdog/
 > 2) drivers/watchdog/
 > 
 > Not sure what's best in this case...

They remain character devices, so drivers/char/watchdog/  gets my vote.
Any nay-sayers ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
