Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWBXSiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWBXSiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBXSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:38:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:39137 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932397AbWBXSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:38:51 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Kernel assertion in net/ipv4/tcp.c
Date: Fri, 24 Feb 2006 10:38:18 -0800
Organization: OSDL
Message-ID: <20060224103818.46510a15@localhost.localdomain>
References: <20060123102805.6bd39bcc@HAL2000>
	<20060224095350.GA5111@kruemel.my-eitzenberger.de>
	<20060224144342.186243cc@HAL2000>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1140806294 307 10.8.0.54 (24 Feb 2006 18:38:14 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 24 Feb 2006 18:38:14 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 14:43:42 +0100
Florian Engelhardt <f.engelhardt@21torr.com> wrote:

> On Fri, 24 Feb 2006 10:53:50 +0100
> Holger Eitzenberger <holger@my-eitzenberger.de> wrote:
> 
> > On Mon, Jan 23, 2006 at 10:28:05AM +0100, Florian Engelhardt wrote:
> > 
> > > Linux www 2.6.14-gentoo-r2 #4 SMP Mon Nov 28 10:35:23 CET 2005 i686
> > > Intel(R) Xeon(TM) CPU 3.20GHz GenuineIntel GNU/Linux
> > > 
> > > I have a Marvell Yukon Ethernet card inside.
> > > 
> > > And i have some trouble with it (see the attached log file).
> > > I get tons of error messages in my kern.log, all the same:
> > > Jan 15 11:11:20 www kernel: KERNEL: assertion (flags & MSG_PEEK)
> > > failed at net/ipv4/tcp.c (1171)
> > 
> > Hi,
> > 
> > I see similar errors here on several boxes, all with Marvel chipsets
> > and sk98lin.  Do you use sk98lin or skge/sky2?
> 
> Hi,
> 
> we are using sk98lin driver.
> 
> Kind regards
> 
> Flo

Is this a new error (did it happen with older kernels)?

Does it go away if you turn receive checksum offload off?
