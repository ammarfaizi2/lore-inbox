Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADKZs>; Thu, 4 Jan 2001 05:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRADKZi>; Thu, 4 Jan 2001 05:25:38 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:38405 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129370AbRADKZY>; Thu, 4 Jan 2001 05:25:24 -0500
Date: Thu, 4 Jan 2001 10:25:14 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Daniel Phillips <phillips@innominate.de>
cc: Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A544D1D.81AD9838@innominate.de>
Message-ID: <Pine.LNX.4.30.0101041021540.10966-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Daniel Phillips wrote:

> > Nothing wrong with a filesystem (or apps) that can handle being
> > powered down. But I prefer to handle this kind of users with a
> > power switch that merely acts as a "shutdown button"  instead of
> > actually killing power. The os will then run the equivalent of
> > "shutdown -h now"
>
> And you give your customer clear instructions that they are not under
> any circumstances to unplug the device without turning it off first?
> And when they do it anyway you void their warranty?

s/unplug the device/remove the battery/ makes it _slightly_ more sensible
but not a lot.

I spent a week with an X10 controller and a device with JFFS root
filesystem running dbench from init, power cycling it every five minutes.
If JFFS at least doesn't survive unclean shutdowns, I want to know about
it.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
