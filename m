Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUCWFXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCWFXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:23:09 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:64949 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262000AbUCWFXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:23:06 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] Move eth into 'lite' series?
Date: Tue, 23 Mar 2004 10:32:54 +0530
User-Agent: KMail/1.5
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040319210322.GA13141@smtp.west.cox.net> <200403201242.21578.amitkale@emsyssoft.com> <20040322144112.GA27175@smtp.west.cox.net>
In-Reply-To: <20040322144112.GA27175@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403231032.55545.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Mar 2004 8:11 pm, Tom Rini wrote:
> On Sat, Mar 20, 2004 at 12:42:21PM +0530, Amit S. Kale wrote:
> > On Saturday 20 Mar 2004 2:33 am, Tom Rini wrote:
> > > I was thinking, now that netpoll is in 2.6.5-rc1, should we move the
> > > kgdboe driver into the -lite series?  I'd like to say Yes, with a quick
> > > check over the include list.
> >
> > Let's wait till current session to push kgdb into mainline kernel is
> > over. We need not push kgdboe into lite series, we can push it into
> > mainline kernel itself :-)
> >
> > I was supposed to submit second version of lite patches monday this week,
> > but was preempted by some other work. I'll post them on coming monday now
>
> Actually, I was thinking just the opposite.  Based on Linus' comments
> (see http://www.ussg.iu.edu/hypermail/linux/kernel/0211.1/1861.html and
> maybe http://www.ussg.iu.edu/hypermail/linux/kernel/0211.2/0089.html
> too) we can always try and get the 8250 serial backend in once kgdb +
> enet driver is already in.

That's true. kgdboe wasn't quite ready last month, otherwise we could have 
gone that way. Let's now change our direction right now. Let's push whatever 
we have. If it doesn't go in, we'll switch to eth driver instead.

-Amit

