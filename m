Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVATHSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVATHSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVATHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:18:32 -0500
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116]:55258 "EHLO
	av1-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261764AbVATHRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:17:41 -0500
Date: Thu, 20 Jan 2005 08:17:38 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Daniel Gryniewicz <daniel@gryniewicz.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.11-rc1
In-Reply-To: <1106196553.11875.2.camel@athena.fprintf.net>
Message-ID: <Pine.LNX.4.58.0501200813330.26770@telia.com>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> 
 <1106168848.22163.10.camel@athena.fprintf.net>  <200501192316.04173.dtor_core@ameritech.net>
 <1106196553.11875.2.camel@athena.fprintf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Daniel Gryniewicz wrote:

> On Wed, 2005-01-19 at 23:16 -0500, Dmitry Torokhov wrote:
> > On Wednesday 19 January 2005 16:07, Daniel Gryniewicz wrote:
> > > On Tue, 2005-01-11 at 21:09 -0800, Linus Torvalds wrote:
> > > > Ok, the big merges after 2.6.10 are hopefully over, and 2.6.11-rc1 is out
> > > > there.
> > > >
> > > > Peter Osterlund:
> > > >   o input: Add ALPS touchpad driver, driver by Neil Brown, Peter
> > > >     Osterlund and Dmitry Torokhov, some fixes by Vojtech Pavlik.
> > >
> > > 2.6.11-rc1 broke my ALPS touchpad.  I have a Dell Inspiron 8600, and
> > > previously, I was patching my kernels with the patch from
> > >
> > > Message-Id: <200407110045.08208.dtor_core@ameritech.net>
> > > Subject: [RFT/PATCH 2.6] ALPS touchpad driver
> > >
> > > and this worked fine.
> > >
> > Could you please try this patch by Peter Osterlund:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=110513688110246&q=raw
> >
> > It looks like Kensington and ALPS hate each other.
>
> That fixed it, thanks.  I hope this can make it in before 2.6.11 final,
> but if it doesn't, I'll just patch it in.

OK, I've got another report in private mail where this patch fixed the
ALPS detection, so the score for this patch is now 3 success reports and 0
problem reports. I also think the patch should be included before 2.6.11
final.

The patch is already in -mm btw, it's called alps-touchpad-detection-fix.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
