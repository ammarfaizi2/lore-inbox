Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWCHXVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWCHXVn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWCHXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:21:42 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32412
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751422AbWCHXVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:21:42 -0500
Date: Wed, 8 Mar 2006 15:21:31 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060308232131.GB26666@suse.de>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de> <20060308230519.GT4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308230519.GT4006@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:05:19AM +0100, Adrian Bunk wrote:
> On Wed, Mar 08, 2006 at 02:50:29PM -0800, Greg KH wrote:
> > > (pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch seems to
> > >  be a candidate.)
> > 
> > Yes, if people really want it in I could send it, but I was just looking
> > for "bugfixes only" at this late stage of the game.
> 
> It is a fix for a hardware bug, and IMHO 2.6.16 material (but I don't a 
> very strong opinion on the latter).

Agreed that it is a hardware bug, but it's pretty low on the scale of
issues, as there is no oops, and no regression.  But if people affected
by it really need it in now, I'm very willing to reconsider.

Just trying to be conservative with changes right now.

thanks,

greg k-h
