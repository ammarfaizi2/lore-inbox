Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWFTS7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFTS7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 14:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFTS7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 14:59:03 -0400
Received: from outmx018.isp.belgacom.be ([195.238.4.117]:25263 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750801AbWFTS7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 14:59:02 -0400
Date: Tue, 20 Jun 2006 20:48:47 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-ID: <20060620184847.GA4607@infomag.infomag.iguana.be>
References: <20060521205810.64b631e2.rdunlap@xenotime.net> <20060522144347.07b08a8c.akpm@osdl.org> <20060522145832.ce45807a.rdunlap@xenotime.net> <20060523203709.GA4651@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523203709.GA4651@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy, Andrew,

> > > >  Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
> > > >   Documentation/watchdog/watchdog-api.txt  |   17 -------
> > > >   Documentation/watchdog/watchdog-simple.c |   15 ++++++
> > > >   Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
> > > >   Documentation/watchdog/watchdog.txt      |   23 ---------
> > > 
> > > Wouldn't it be better to move all the .c files into a new directory? 
> > > Documentation/src or something?
> > 
> > I dunno.  I like using multiple subdirectories (like watchdog/,
> > laptop/, block/, etc.) and not cluttering up Documentation/
> > with them.
> 
> I think a "user" that wants to know something specific about watchdog drivers
> will look in Documentation/watchdog and try to find what he need as fast as
> he can. I would say Documentation/watchdog/src/ then...

I'm going to change this patch so that we put the .c files in
Documentation/watchdog/src/ . I presume this is ok for both of you?

Thanks,
Wim.

