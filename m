Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUCVOlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUCVOlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:41:17 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:6287 "EHLO fed1mtao03.cox.net")
	by vger.kernel.org with ESMTP id S261505AbUCVOlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:41:16 -0500
Date: Mon, 22 Mar 2004 07:41:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] Move eth into 'lite' series?
Message-ID: <20040322144112.GA27175@smtp.west.cox.net>
References: <20040319210322.GA13141@smtp.west.cox.net> <200403201242.21578.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403201242.21578.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:42:21PM +0530, Amit S. Kale wrote:

> On Saturday 20 Mar 2004 2:33 am, Tom Rini wrote:
> > I was thinking, now that netpoll is in 2.6.5-rc1, should we move the
> > kgdboe driver into the -lite series?  I'd like to say Yes, with a quick
> > check over the include list.
> 
> Let's wait till current session to push kgdb into mainline kernel is over. We 
> need not push kgdboe into lite series, we can push it into mainline kernel 
> itself :-)
> 
> I was supposed to submit second version of lite patches monday this week, but 
> was preempted by some other work. I'll post them on coming monday now

Actually, I was thinking just the opposite.  Based on Linus' comments
(see http://www.ussg.iu.edu/hypermail/linux/kernel/0211.1/1861.html and
maybe http://www.ussg.iu.edu/hypermail/linux/kernel/0211.2/0089.html
too) we can always try and get the 8250 serial backend in once kgdb +
enet driver is already in.

-- 
Tom Rini
http://gate.crashing.org/~trini/
