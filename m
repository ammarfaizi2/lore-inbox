Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWCHXe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWCHXe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWCHXe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:34:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31461 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751483AbWCHXe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:34:58 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20060308232350.GA26929@suse.de>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <20060308230519.GT4006@stusta.de> <1141859917.767.242.camel@mindpipe>
	 <20060308232350.GA26929@suse.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 18:34:54 -0500
Message-Id: <1141860895.767.251.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:23 -0800, Greg KH wrote:
> 
> > That should not go in 2.6.16 - it's not a hardware bug but a (poor IMHO)
> > design decision by the vendor.  And, it may break working setups when an
> > extra sound device shows up.
> 
> Ah, good thing I held off :)
> 
> Any objections to it going in for 2.6.17?

I can't think of a way to merge this and guarantee not to break
userspace unless it could be disabled by default.

Lee

