Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272756AbTG3FWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272759AbTG3FWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:22:25 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:50413 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S272756AbTG3FWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:22:24 -0400
Date: Wed, 30 Jul 2003 08:22:13 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730052213.GU150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	James Simmons <jsimmons@infradead.org>,
	Charles Lepple <clepple@ghz.cc>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 08:17:15PM -0400, you [Zwane Mwaikambo] wrote:
> On Tue, 29 Jul 2003, Richard B. Johnson wrote:
> 
> > If the machine had blanking disabled by default, then the
> > usual SYS-V startup scripts could execute setterm to enable
> > it IFF it was wanted.
> 
> optimise for the common case, 

I would argue the other way around. The majority of desktop users run X,
console blanking won't help them anyway. The server users tend to have KVM
or switch monitor cables on the fly - in most such cases console blanking
hurts more than helps (since you can't tell which box is connected to which
monitor etc.)

And console blanking is not real DPMS power save anyway.

> just fix your box and be done with it.

Most times when you need to have it fixed is when your box has mysteriously
locked up, and you'd wan't to know if there was a oops on the screen. No can
do - the console is already blanked. By then it is too late to fix it.

In what cases is console blanking so hugely important these days, anyway?


-- v --

v@iki.fi
