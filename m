Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVDAVyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVDAVyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVDAVvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:51:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:40082 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262951AbVDAV0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:26:37 -0500
Subject: Re: [PATCH] clean up kernel messages
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112390323.578.1.camel@localhost.localdomain>
References: <20050401200851.GG15453@waste.org>
	 <20050401122641.7c52eaab.akpm@osdl.org>  <20050401204629.GJ15453@waste.org>
	 <1112390323.578.1.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 01 Apr 2005 16:26:25 -0500
Message-Id: <1112390785.578.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 16:18 -0500, Steven Rostedt wrote:
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

Arg! I'm too tired.  I took another look at your other patches and they
look more legit now. On first glance, I thought you were just bluntly
removing BUGs and error messages to quiet things down. But after taking
another look, I see that they are more than that.  I wouldn't of thought
about that on any other day.

Sorry,


-- Steve


