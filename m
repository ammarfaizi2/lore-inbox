Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSLMFjG>; Fri, 13 Dec 2002 00:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSLMFjG>; Fri, 13 Dec 2002 00:39:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261446AbSLMFjF>;
	Fri, 13 Dec 2002 00:39:05 -0500
Date: Thu, 12 Dec 2002 21:42:39 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Rod Van Meter <Rod.VanMeter@nokia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: massive compile failures w/ 2.5.51 on RH8.0
In-Reply-To: <20021213002750.GB18156@suse.de>
Message-ID: <Pine.LNX.4.33L2.0212122140500.21077-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Dave Jones wrote:

| On Thu, Dec 12, 2002 at 04:06:59PM -0800, Rod Van Meter wrote:
|
|  > At this point I've concluded that something in my setup is busted.
|  > Surely this large a fraction of things don't currently fail to even
|  > compile?
|
| This large a fraction of things don't currently compile.
| And don't call me Shirley. 8-)
|
| Seriously, you got unlucky, and seem to be hitting just about
| every broken driver/filesystem there is in 2.5 right now.
| If you take a look at bugzilla.kernel.org you'll see that
| most of the compile errors noted there are those that you've
| highlighted.
|
| Things like Intermezzo don't affect a large proportion of users,
| so remain broken for some time. The framebuffer changes in 2.5.51
| fixed up a whole bunch of problems that had been lingering for
| a while, but there's still a lot of drivers not converted over
| to the new API.
|
| Compile-time breakage is to be expected in 2.5.x. It's a hard-hat
| area. You may have more luck with 2.5-ac.

and some of these may have patches available for them on lkml.
I know that intermezzo does, from Peter Braam, with a small
follow-up by me, so it's fixable if you want it.  Surely (Rod ;).

-- 
~Randy

