Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUBTWv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUBTWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:51:25 -0500
Received: from gprs151-132.eurotel.cz ([160.218.151.132]:27010 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261406AbUBTWsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:48:47 -0500
Date: Fri, 20 Feb 2004 23:48:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
Message-ID: <20040220224836.GA32153@elf.ucw.cz>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet> <20040218055744.GC15660@alpha.home.local> <Pine.LNX.4.58L.0402181132480.4852@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402181132480.4852@logos.cnet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Wed, Feb 18, 2004 at 02:11:24AM -0300, Marcelo Tosatti wrote:
> > > Here goes release candidate 4, including a few small fixes.
> > >
> > > If nothing bad shows up, this will become final.
> >
> > Well, I would have liked to see the ACPI poweroff fix I sent a few days ago,
> > but Len said he doesn't have time to review it this week. It's a shame since
> > at least two of my machines which powered off correctly with very older ACPI
> > versions now need it, so I don't think I'm the only one in this case :-(
> >
> > Other than that, I'm fairly happy with at least -rc2 (not tested latest
> > releases yet).
> 
> Hi Willy,
> 
> Your fix looks ok. I dont think calling acpi_system_save_state(S5) can
> cause any breakage. Len?

I bet it will create "machine will reboot instead of poweroff" on some
strange machine.... Perhaps it fixes more machines than it breaks, but
it will probably break some.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
