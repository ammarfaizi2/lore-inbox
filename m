Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVDAVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVDAVVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVDAVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:20:55 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61435 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262911AbVDAVS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 16:18:56 -0500
Subject: Re: [PATCH] clean up kernel messages
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050401204629.GJ15453@waste.org>
References: <20050401200851.GG15453@waste.org>
	 <20050401122641.7c52eaab.akpm@osdl.org>  <20050401204629.GJ15453@waste.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 01 Apr 2005 16:18:42 -0500
Message-Id: <1112390323.578.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 12:46 -0800, Matt Mackall wrote:
> On Fri, Apr 01, 2005 at 12:26:41PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > This patch tidies up those annoying kernel messages. A typical kernel
> > >  boot now looks like this:
> > > 
> > >  Loading Linux... Uncompressing kernel...
> > >  #
> > > 
> > >  See? Much nicer. This patch saves about 375k on my laptop config and
> > >  nearly 100k on minimal configs.
> > > 
> > 
> > heh.  Please take a look at
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0004.2/0709.html, see if
> > Graham did anything which you missed.
> 
> He's got a bunch of stuff that's not strictly related in there and
> stuff I've already dealt with (vprintk and the like) and stuff that's
> still forthcoming (panic tweaks, etc.). I also leave in all the APIs
> like dmesg, they just no longer do anything.

Looking at your other patches, I'm assuming that this is just another
April 1st type of patch. Is it?

-- Steve


