Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWHNPaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWHNPaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWHNPaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:30:39 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:64482 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750823AbWHNPai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:30:38 -0400
Date: Mon, 14 Aug 2006 17:30:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Koeller <thomas@koeller.dyndns.org>, Dave Jones <davej@redhat.com>,
       wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814153033.GA25215@mars.ravnborg.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org> <20060814141445.GA10763@nineveh.rivenstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814141445.GA10763@nineveh.rivenstone.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:14:45AM -0400, Joseph Fannin wrote:
> On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> > On Friday 11 August 2006 22:56, Dave Jones wrote:
> > > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
> > >  > +
> > >  > +#include <linux/config.h>
> > >
> > > not needed.
> >
> > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.
Yes you do - try it.
make V=1 tells you that -include include/linux/autoconf.h pulls in the
CONFIG_ definitions.

	Sam
