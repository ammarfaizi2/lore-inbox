Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVHMWxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVHMWxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 18:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVHMWxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 18:53:17 -0400
Received: from mail.gmx.de ([213.165.64.20]:137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932388AbVHMWxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 18:53:17 -0400
X-Authenticated: #20450766
Date: Sat, 13 Aug 2005 22:49:58 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is it possible to control C.O.P
In-Reply-To: <42FBDD74.1010608@shaw.ca>
Message-ID: <Pine.LNX.4.60.0508132221060.12478@poirot.grange>
References: <4AfFW-xN-5@gated-at.bofh.it> <42FBDD74.1010608@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Robert Hancock wrote:

> Luigi Genoni wrote:
> > HI,
> > there is a way that the kernel could cope with CPU Overheating Protection?
> > 
> > I am usng a Tyan MPX with Dual AthlonMP, but COP is configured to shutdown
> > the system toot early, when the temparature is still low.
> 
> I'm guessing this is controlled by the BIOS and handled by hardware, so I
> don't know that there's much the kernel can do about it. Is there a threshold
> temperature setting in the BIOS?

Not sure what you mean by "shutdown" - the OS shuts down the system 
cleanly or the BIOS just switches off the power? If the former, you, most 
probably, just have wrongly configured sensors. I had a problem with 
fictitious CPU overheating, until I modified my /etc/sensors.conf. Just 
ask on sensors@stimpy.netroedge.com - no need to subscribe, people are 
very helpful there.

HTH
Guennadi
---
Guennadi Liakhovetski
