Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTIPXou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTIPXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:44:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:28395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262575AbTIPXot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:44:49 -0400
Subject: Re: Linux 2.6.0-test5 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909155118.GA18763@gtf.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
	 <1063065853.10623.449.camel@cherrypit.pdx.osdl.net>
	 <3F5D4CB1.3060001@pobox.com>
	 <1063119969.1512.1.camel@cherrypit.pdx.osdl.net>
	 <20030909155118.GA18763@gtf.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063755877.21105.25.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 Sep 2003 16:44:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I added allyesconfig to the stats.  Check out...

http://developer.osdl.org/cherry/compile/

John


On Tue, 2003-09-09 at 08:51, Jeff Garzik wrote:
> On Tue, Sep 09, 2003 at 08:06:09AM -0700, John Cherry wrote:
> > On Mon, 2003-09-08 at 20:44, Jeff Garzik wrote:
> > > John Cherry wrote:
> > > > Compile statistics: 2.6.0-test5
> > > > Compiler: gcc 3.2.2
> > > > Script: http://developer.osdl.org/~cherry/compile/compregress.sh
> > > > 
> > > > Note: the numbers look drastically better, but this is skewed
> > > >       by the fact that CONFIG_CLEAN_COMPILE is now the default
> > > >       for defconfig and allmodconfig.
> > > > 
> > > >                bzImage       bzImage        modules
> > > >              (defconfig)  (allmodconfig) (allmodconfig)
> > > 
> > > 
> > > Any chance you can add "bzImage (allyesconfig)"?
> > 
> > I did allyesconfig for awhile and found it to be a subset of
> > allmodconfig (for the most part).  However, it would be an interesting
> > data point, so I think I'll add it back in.
> 
> Thanks.
> 
> The "for the most part" is key -- allyesconfig often shows problems that
> allmodconfig does not, precisely because (a) most people build drives as
> modules and (b) it shows missing symbols and similar problems obviously
> and immediately, since the final link will fail unless everything is
> 100% ok.  (well, I think the link may fail for size reasons, I don't
> recall exactly...)
> 
> 	Jeff
> 
> 

