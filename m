Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbTDPTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTDPTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:04:28 -0400
Received: from galileo.bork.org ([66.11.174.148]:62480 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S264541AbTDPTE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:04:27 -0400
Date: Wed, 16 Apr 2003 15:16:19 -0400
From: Martin Hicks <mort@wildopensource.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Daniel Stekloff <dsteklof@us.ibm.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Martin Hicks <mort@wildopensource.com>, hpa@zytor.com, pavel@ucw.cz,
       jes@wildopensource.com, linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030416191619.GA3413@bork.org>
References: <200304141533.18779.dsteklof@us.ibm.com> <Pine.LNX.4.44.0304161140160.912-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304161140160.912-100000@cherise>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Apr 16, 2003 at 11:42:59AM -0700, Patrick Mochel wrote:
> 
> > I like the idea of having logging levels, which include debug, defined by 
> > subsystem. Each subsystem will have separate requirements for logging. 
> > Networking, for instance, already has the NETIF_MSG* levels defined in 
> > netdevice.h that can be set with Ethtool. I can see, for example, having the 
> > msg_enable not in the private data as it is now but in the subsystem or class 
> > structure for that device, such as in struct net_device. This could easily be 
> > exported through sysfs. 
> 
> It would be nice. Unfortunately, it's only a nifty pipe-dream at the 
> moment, unless some lucky volunteer would like to step forward. ;)
> 


I guess my question is this:

Is the patch I posted useful enough to go into the kernel?  I think it
is.  It introduces very little overhead, and provides most of the
functionality that you guys are discussing.  It does use sysctl, and not
sysfs but does that really matter?

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com
