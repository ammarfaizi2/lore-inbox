Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWEKXqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWEKXqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEKXqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:46:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:6893 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750834AbWEKXqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:46:51 -0400
Date: Thu, 11 May 2006 16:44:52 -0700
From: Greg KH <greg@kroah.com>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coldpluging or USB Issues ?
Message-ID: <20060511234452.GA18542@kroah.com>
References: <4462F4E1.4060008@plutohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4462F4E1.4060008@plutohome.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 11:25:05AM +0300, Razvan Gavril wrote:
> As far as i know since 2.6.15 there is a new coldplug mechanism using 
> uevent and switching to a newer version of udevd that can do the cold 
> plugging and replacing the old hotplug scripts would be the natural next 
> step but before doing this i need to ask some questions like :
> 1) Where there any changes sine 2.6.15 that could cause the old hotplug 
> scripts to work reliable because most part of the time (95%) they are 
> working ?

I don't know, what is failing?

> 2) Upgrading to newer version of udevd to let the udev scripts to do 
> the coldpluging can solve any issues that where described ?

Probably, that's what all of the major distros have already done.  It
makes the startup logic much smaller and simpler.

This should be continued on the linux-hotplug-devel mailing list if you
are interested.

thanks,

greg k-h
