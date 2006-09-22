Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWIVEyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWIVEyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 00:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWIVEyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 00:54:09 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:41572 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932100AbWIVEyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 00:54:06 -0400
Subject: Re: R200 lockup (was Re: DRI/X error resolution)
From: Stephen Olander Waters <swaters@luy.info>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <20060922043801.GE16939@tau.solarneutrino.net>
References: <1158898988.3280.8.camel@ix>
	 <20060922043801.GE16939@tau.solarneutrino.net>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 23:54:01 -0500
Message-Id: <1158900841.3280.12.camel@ix>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 00:38 -0400, Ryan Richter wrote:
> On Thu, Sep 21, 2006 at 11:23:08PM -0500, Stephen Olander Waters wrote:
> > Hey,
> > 
> > Did they ever fix that bug you reported here?
> > http://lkml.org/lkml/2005/5/11/121
> > 
> > I'm having the same problem! Argh!
> 
> No, sad to say it still happens to us too.  Argh is right!
> 
> I'll cc this to dri-devel and lkml in case anyone wants to try hunting
> the bug again.
> 
> FWIW, I'm still seeing the ioctl(5, 0x6444, 0) / SIGALARM behavior I
> reported originally.  This has continued to happen regularly with all
> 2.6 kernels up to 2.6.17.6 and Xfree/X.org up to 6.9.

Here is the bug I'm working from (includes hardware, software, etc.):
https://bugs.freedesktop.org/show_bug.cgi?id=6111

DRI will work if you set: Option "BusType" "PCI" ... but that's not a
real solution. :)

-s


