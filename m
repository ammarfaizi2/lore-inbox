Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTFEUI4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFEUI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:08:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25247 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265091AbTFEUIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:08:53 -0400
Date: Thu, 5 Jun 2003 12:47:34 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>,
       Martin Schlemmer <azarah@gentoo.org>
Subject: Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-ID: <20030605194734.GA6238@kroah.com>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private> <20030602172040.GC4992@kroah.com> <20030605023922.GA8943@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605023922.GA8943@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 10:39:22PM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2003-06-02 10:20:40 -0700]:
> > On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> > > 
> > > This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> > > re-testing against an ISA adapter since my particular chip is SMBus only.
> > 
> > I've applied this and will send it off to Linus in a bit.
> 
> Thanks!
> 
> This patch fixes the various return values in the w83781d_detect()
> error paths.  It also cleans up some formatting here and there.
> It should be applied on top of the previous one.
> 
> It works for me; same caveat as above w.r.t. ISA.

Applied, thanks.

greg k-h
