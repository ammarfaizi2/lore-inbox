Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbSJNPyQ>; Mon, 14 Oct 2002 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSJNPyQ>; Mon, 14 Oct 2002 11:54:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261744AbSJNPyP>;
	Mon, 14 Oct 2002 11:54:15 -0400
Date: Mon, 14 Oct 2002 08:58:02 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Wim Van Sebroeck <wim@iguana.be>
cc: Dave Jones <davej@codemonkey.org.uk>, Rob Radez <rob@osinvestor.com>,
       Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Watchdog drivers
In-Reply-To: <20021014144158.A19209@medelec.uia.ac.be>
Message-ID: <Pine.LNX.4.33L2.0210140857050.24860-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Wim Van Sebroeck wrote:

| On Mon, Oct 14, 2002 at 01:22:39PM +0100, Dave Jones wrote:
|
| >  > Now I'm still left with my original question: wouldn't it be easier if we
| >  > put all watchdog drivers in drivers/char/watchdog/ ?
| >
| > I'd say go for it. drivers/char/ is looking quite cluttered, and this
| > has the added advantage of decreasing the size of the Config.in and
| > config.help files too.
|
| I still see two options:
| 1) drivers/char/watchdog/
| 2) drivers/watchdog/
|
| Not sure what's best in this case...

I agree that you should split them out.
I would expect them to be in drivers/char/watchdog .

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

