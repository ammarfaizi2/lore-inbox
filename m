Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWFTTLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWFTTLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFTTLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:11:00 -0400
Received: from xenotime.net ([66.160.160.81]:20871 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750785AbWFTTLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:11:00 -0400
Date: Tue, 20 Jun 2006 12:13:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-Id: <20060620121342.61976088.rdunlap@xenotime.net>
In-Reply-To: <20060620184847.GA4607@infomag.infomag.iguana.be>
References: <20060521205810.64b631e2.rdunlap@xenotime.net>
	<20060522144347.07b08a8c.akpm@osdl.org>
	<20060522145832.ce45807a.rdunlap@xenotime.net>
	<20060523203709.GA4651@infomag.infomag.iguana.be>
	<20060620184847.GA4607@infomag.infomag.iguana.be>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 20:48:47 +0200 Wim Van Sebroeck wrote:

> Randy, Andrew,
> 
> > > > >  Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
> > > > >   Documentation/watchdog/watchdog-api.txt  |   17 -------
> > > > >   Documentation/watchdog/watchdog-simple.c |   15 ++++++
> > > > >   Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
> > > > >   Documentation/watchdog/watchdog.txt      |   23 ---------
> > > > 
> > > > Wouldn't it be better to move all the .c files into a new directory? 
> > > > Documentation/src or something?
> > > 
> > > I dunno.  I like using multiple subdirectories (like watchdog/,
> > > laptop/, block/, etc.) and not cluttering up Documentation/
> > > with them.
> > 
> > I think a "user" that wants to know something specific about watchdog drivers
> > will look in Documentation/watchdog and try to find what he need as fast as
> > he can. I would say Documentation/watchdog/src/ then...
> 
> I'm going to change this patch so that we put the .c files in
> Documentation/watchdog/src/ . I presume this is ok for both of you?

Sure, OK for me.  Thanks.

---
~Randy
