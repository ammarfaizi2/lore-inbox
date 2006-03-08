Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWCHXSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWCHXSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCHXSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:18:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34274 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751341AbWCHXSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:18:40 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20060308230519.GT4006@stusta.de>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <20060308230519.GT4006@stusta.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 18:18:36 -0500
Message-Id: <1141859917.767.242.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 00:05 +0100, Adrian Bunk wrote:
> > > (pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch seems to
> > >  be a candidate.)
> > 
> > Yes, if people really want it in I could send it, but I was just looking
> > for "bugfixes only" at this late stage of the game.
> 
> It is a fix for a hardware bug, and IMHO 2.6.16 material (but I don't a 
> very strong opinion on the latter).
> 

This is the patch that re-enabled the onboard sound card when a second
one is present?

That should not go in 2.6.16 - it's not a hardware bug but a (poor IMHO)
design decision by the vendor.  And, it may break working setups when an
extra sound device shows up.

Lee

