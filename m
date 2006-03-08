Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWCHXkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWCHXkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWCHXkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:40:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18905
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751513AbWCHXkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:40:18 -0500
Date: Wed, 8 Mar 2006 15:40:04 -0800
From: Greg KH <gregkh@suse.de>
To: Lee Revell <rlrevell@joe-job.com>, bjdouma@xs4all.nl
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060308234004.GA31309@suse.de>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de> <20060308230519.GT4006@stusta.de> <1141859917.767.242.camel@mindpipe> <20060308232350.GA26929@suse.de> <1141860895.767.251.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141860895.767.251.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 06:34:54PM -0500, Lee Revell wrote:
> On Wed, 2006-03-08 at 15:23 -0800, Greg KH wrote:
> > 
> > > That should not go in 2.6.16 - it's not a hardware bug but a (poor IMHO)
> > > design decision by the vendor.  And, it may break working setups when an
> > > extra sound device shows up.
> > 
> > Ah, good thing I held off :)
> > 
> > Any objections to it going in for 2.6.17?
> 
> I can't think of a way to merge this and guarantee not to break
> userspace unless it could be disabled by default.

Ok, how about you and Bauke (CCed, and the author of the patch) work
together on the problem and let me know what you decide on.

thanks,

greg k-h
