Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129564AbRBYSzl>; Sun, 25 Feb 2001 13:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129571AbRBYSzc>; Sun, 25 Feb 2001 13:55:32 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5892 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129564AbRBYSzR>;
	Sun, 25 Feb 2001 13:55:17 -0500
Message-ID: <20010225192454.A1697@bug.ucw.cz>
Date: Sun, 25 Feb 2001 19:24:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Johannes Erdfelt <johannes@erdfelt.com>,
        Pifko Krisztian <pifko@kirowski.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] philips rush usb support
In-Reply-To: <Pine.LNX.4.30.0102241730370.19866-100000@pifko.kirowski.com> <20010224121312.S16341@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010224121312.S16341@sventech.com>; from Johannes Erdfelt on Sat, Feb 24, 2001 at 12:13:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've made a patch which adds usb support for the philips
> > rush mp3 player. The driver is mainly the rio500 driver
> > only the rush specific parts were modified.
> > 
> > The patch is against 2.4.2.
> > 
> > It uses char 180 65 at /dev/usb/rush.
> > 
> > Userspace stuff should be found at http://openrush.sourceforge.net
> > if you have a rush. It works for me on ia32 with the model sa125.
> 
> Why can't the entire driver be in userspace? It appears it uses a
> completely proprietary protocol and you've created a completely
> proprietary interface to the kernel.

Would not making it "usb-serial" device do the trick?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
