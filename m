Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVDAVyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVDAVyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVDAVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:52:21 -0500
Received: from waste.org ([216.27.176.166]:52896 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262937AbVDAVcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:32:48 -0500
Date: Fri, 1 Apr 2005 13:32:40 -0800
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up kernel messages
Message-ID: <20050401213240.GK15453@waste.org>
References: <20050401200851.GG15453@waste.org> <20050401122641.7c52eaab.akpm@osdl.org> <20050401204629.GJ15453@waste.org> <1112390323.578.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112390323.578.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 04:18:42PM -0500, Steven Rostedt wrote:
> On Fri, 2005-04-01 at 12:46 -0800, Matt Mackall wrote:
> > On Fri, Apr 01, 2005 at 12:26:41PM -0800, Andrew Morton wrote:
> > > Matt Mackall <mpm@selenic.com> wrote:
> > > >
> > > > This patch tidies up those annoying kernel messages. A typical kernel
> > > >  boot now looks like this:
> > > > 
> > > >  Loading Linux... Uncompressing kernel...
> > > >  #
> > > > 
> > > >  See? Much nicer. This patch saves about 375k on my laptop config and
> > > >  nearly 100k on minimal configs.
> > > > 
> > > 
> > > heh.  Please take a look at
> > > http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html, see if
> > > Graham did anything which you missed.
> > 
> > He's got a bunch of stuff that's not strictly related in there and
> > stuff I've already dealt with (vprintk and the like) and stuff that's
> > still forthcoming (panic tweaks, etc.). I also leave in all the APIs
> > like dmesg, they just no longer do anything.
> 
> Looking at your other patches, I'm assuming that this is just another
> April 1st type of patch. Is it?

Both this and the previous one are in active use by various embedded
systems folks and I hope to get them integrated into mainline.
Comments welcome.

-- 
Mathematics is the supreme nostalgia of our time.
