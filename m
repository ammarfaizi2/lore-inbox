Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVBBW0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVBBW0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVBBWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:22:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:32169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262289AbVBBWTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:19:44 -0500
Date: Wed, 2 Feb 2005 14:19:07 -0800
From: Greg KH <greg@kroah.com>
To: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050202221907.GA13680@kroah.com>
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com> <20050201220552.GA13994@kroah.com> <20050202071001.GB25641@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202071001.GB25641@linux-sh.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:10:01AM +0200, Paul Mundt wrote:
> On Tue, Feb 01, 2005 at 02:05:52PM -0800, Greg KH wrote:
> > On Wed, Jan 12, 2005 at 02:48:36PM +0200, Paul Mundt wrote:
> > > Yes, it would seem that way. Here we go again:
> > > 
> > >  drivers/sh/Makefile                      |    6 
> > >  drivers/sh/superhyway/Makefile           |    7 +
> > >  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
> > >  drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
> > >  include/linux/superhyway.h               |   79 ++++++++++++
> > >  5 files changed, 338 insertions(+)
> > 
> > Sorry for taking so long on this.  I've added it to my trees and it will
> > show up in the next -mm releases.  After 2.6.11 is out I'll forward it
> > on to Linus.
> > 
> There's an older version of this patch currently still in -mm, so this
> patch won't actually apply there directly. I can send an incremental -mm
> patch that gets the current -mm implementation up to date with these
> changes (or if Andrew can back out the current patch in -mm and apply this
> one in place, that works too).

If Andrew could just drop the patch in his tree, he will get this
version in through the bk-drivers tree that he pulls into the -mm
releases.

thanks,

greg k-h
