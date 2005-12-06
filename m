Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVLFJQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVLFJQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 04:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVLFJQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 04:16:54 -0500
Received: from ns.firmix.at ([62.141.48.66]:14750 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932475AbVLFJQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 04:16:53 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Bernd Petrovitsch <bernd@firmix.at>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Willy Tarreau <willy@w.ods.org>, Greg KH <greg@kroah.com>,
       Tim Bird <tim.bird@am.sony.com>, Dave Airlie <airlied@gmail.com>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <1133856790.4136.5.camel@baythorne.infradead.org>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	 <4394DA1D.3090007@am.sony.com> <20051206040820.GB26602@kroah.com>
	 <20051206060734.GB7096@alpha.home.local>
	 <1133856790.4136.5.camel@baythorne.infradead.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 06 Dec 2005 10:10:13 +0100
Message-Id: <1133860213.10158.19.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 08:13 +0000, David Woodhouse wrote:
> On Tue, 2005-12-06 at 07:07 +0100, Willy Tarreau wrote:
> > Most of those small companies who propose a Linux driver simply start
> > by paying a student during summer for porting their
> > windows/sco/whatever driver to linux. They think the job is done when
> > he leaves. Unfortunately, they receive complaints 3 months later from
> > users because the driver is broken and does not build. They don't have
> > the resources to keep a permanent developer on it, and they quickly
> > understand that Linux is just a "geek OS" and that it's the last time
> > they release any driver.
> 
> If they hired someone who did a _proper_ job -- writing a fully portable
> and maintainable driver which got merged into Linus' kernel, then this

Then you have to motivate the management that it the initial development
cost is (roughly) doubled because of the process to get it accepted into
the kernel (instead of having a bloated converted driver from $OTHER_OS
which works just now somehow). And they didn't realize that bitrotting
is much faster in the free world then in the old-economy (i.e. Win*).

> scenario doesn't make much sense. In-kernel code does generally get
> maintained as interfaces change.

Yes, most of them (until the maintainer vanishes and after a year of
not-compiling-since-no-one-apparently-cares a patch to delete it is
submitted).

> Of course, maintaining a driver _outside_ the kernel tree is a
> never-ending task -- but why would anybody ever want to do that?

-) Because it was never accepted (yes, there are lots of reasons here -
   some are more valid, some are less valid as seen by the
   company/management financinf this)?
-) Because the have drivers + user-space libs for several OSes and want
   to keep them as similar and working together as possible?
-) __________________

And probably a few more (sane reasons, not insane reasons).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

