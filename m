Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269657AbUHZWCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269657AbUHZWCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269712AbUHZV6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:58:48 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:32943 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269727AbUHZVml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:42:41 -0400
Date: Thu, 26 Aug 2004 22:41:38 +0100
From: Dave Jones <davej@redhat.com>
To: jmerkey@comcast.net
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040826214138.GA11336@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jmerkey@comcast.net,
	William Lee Irwin III <wli@holomorphy.com>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
	jmerkey@drdos.com
References: <082620042024.23755.412E47050006895C00005CCB2200751150970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082620042024.23755.412E47050006895C00005CCB2200751150970A059D0A0306@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 08:24:38PM +0000, jmerkey@comcast.net wrote:
 
 > What do you plan to do when the driver base becomes as 
 > large as the one in WIndows 2000/XP

There's a slew of drivers for ancient hardware in Linux that will /never/
be supported in Windows 2000/XP. Given we also support a majority of modern
hardware, chances are we're either comparable, or maybe even surpassing
Microsoft in terms of number of drivers shipped.

 > and you don't have enough memory to load all the drivers.

Since when do we load /all/ the drivers ? That would be silly.

 > Right now, iptables barfs even with 3GB of address space when you load up
 > about a dozen virtual network interfaces ?

I'll hazard a guess this has nothing whatsoever do to with address space sizes.

 > Microsoft had this same problem (only at a much sooner juncture in their
 > platform evolution) and went to VM support in the kernel
 > itself to increase virtual address space for kernel apps, file systems, and
 > drivers when thye hit the wall.    It's coming time to start thinking about
 > it.  

If we did stupid things like trying to load every single driver, maybe.
But we don't, so I think you're chasing ghosts.

		Dave

