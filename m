Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWHNQSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWHNQSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWHNQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:18:41 -0400
Received: from xenotime.net ([66.160.160.81]:56208 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751485AbWHNQSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:18:40 -0400
Date: Mon, 14 Aug 2006 09:21:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Koeller <thomas@koeller.dyndns.org>, Dave Jones <davej@redhat.com>,
       wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-Id: <20060814092124.84f7ff3e.rdunlap@xenotime.net>
In-Reply-To: <20060814153033.GA25215@mars.ravnborg.org>
References: <200608102319.13679.thomas@koeller.dyndns.org>
	<20060811205639.GK26930@redhat.com>
	<200608120149.23380.thomas@koeller.dyndns.org>
	<20060814141445.GA10763@nineveh.rivenstone.net>
	<20060814153033.GA25215@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 17:30:33 +0200 Sam Ravnborg wrote:

> On Mon, Aug 14, 2006 at 10:14:45AM -0400, Joseph Fannin wrote:
> > On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> > > On Friday 11 August 2006 22:56, Dave Jones wrote:
> > > > On Thu, Aug 10, 2006 at 11:19:13PM +0200,
> > > > thomas@koeller.dyndns.org wrote:
> > > >  > +
> > > >  > +#include <linux/config.h>
> > > >
> > > > not needed.
> > >
> > > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.
> Yes you do - try it.
> make V=1 tells you that -include include/linux/autoconf.h pulls in
> the CONFIG_ definitions.

Sure, autoconf.h is included, but I think his point is that
CONFIG_WATCHDOG_NOWAYOUT may not be defined there at all,
as in my 2.6.18-rc4 autoconf.h file, since my .config file says:
# CONFIG_WATCHDOG_NOWAYOUT is not set

---
~Randy
