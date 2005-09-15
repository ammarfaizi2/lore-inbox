Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVIODHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVIODHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 23:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbVIODHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 23:07:32 -0400
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:43938 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030352AbVIODHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 23:07:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev FAQ from the other side
Date: Wed, 14 Sep 2005 22:07:17 -0500
User-Agent: KMail/1.8.2
Cc: David Lang <david.lang@digitalinsight.com>, Robert Love <rml@novell.com>,
       Mike Bell <mike@mikebell.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
References: <20050915005105.GD15017@mikebell.org> <1126746518.9652.60.camel@phantasy> <Pine.LNX.4.62.0509141911530.8469@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0509141911530.8469@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142207.18478.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 21:13, David Lang wrote:
> On Wed, 14 Sep 2005, Robert Love wrote:
> 
> >>   Took an actual devfs system of mine and disabled devfs from the
> >>   kernel, then enabled hotplug and sysfs for udev to run.  make clean
> >>   and surprise surprise, kernel is much bigger. Enable netlink stuff and
> >>   it's bigger still. udev is only smaller if like Greg you don't count
> >>   its kernel components against it, even if they wouldn't otherwise need
> >>   to be enabled. Difference is to the tune of 604164 on udev and 588466
> >>   on devfs. Maybe not a lot in some people's books, but a huge
> >>   difference from the claims of other people that devfs is actually
> >>   bigger.
> >
> > What modern system, though, could survive without hotplug and sysfs and
> > netlink?  You need to have those components, you want those features,
> > anyhow.
> 
> most servers and embedded systems can survive just fine without hotplug 
> (in fact hotplug is frequently the slowest part of the boot).
> 

I wonder why udev or devfs is so much needed for an embedded system with
a static and very limited set of devices? Make static /dev and get rid
of both.

And as far as servers go - you start them and you leave them alone. Who
cares how long this things boots if you do it once a month?

-- 
Dmitry
