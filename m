Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSKMUPt>; Wed, 13 Nov 2002 15:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKMUPt>; Wed, 13 Nov 2002 15:15:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3859 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263279AbSKMUPr>;
	Wed, 13 Nov 2002 15:15:47 -0500
Date: Wed, 13 Nov 2002 12:17:10 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
Message-ID: <20021113201710.GB7238@kroah.com>
References: <3DD2B1D5.7020903@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD2B1D5.7020903@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:11:01PM -0800, David Brownell wrote:
> The module-init-tools-0.6.tar.gz utilities (or something
> related -- kbuild changes?) break hotplug since they no
> longer produce the /lib/modules/$(uname -r)/modules.*map
> files as output ... so the hotplug agents don't have the
> pre-built database mapping device info to drivers.

Last I heard, Rusty's still working on this.  He's also going to be
changing the format so we don't expose kernel structures to userspace,
which would be a good thing.

In short, he knows this is a requirement, and shouldn't be broken for
long.

thanks,

greg k-h
