Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVEJWmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVEJWmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVEJWmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:42:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:46502 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261796AbVEJWmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:42:06 -0400
Date: Tue, 10 May 2005 15:41:59 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510224159.GB4967@kroah.com>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509211323.GB5297@tsiryulnik>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 11:13:24PM +0200, Per Svennerbrandt wrote:
> 
> Along with it I also have a patch witch exports the module aliases for
> PCI and USB devices through sysfs. With it the "coldplugging" of a
> system (module wise) can be reduced to pretty much:

I'd like to see this, that should be acceptable to add to the kernel.

> #!/bin/sh
> 
> for DEV in /sys/bus/{pci,usb}/devices/*; do
> 	modprobe `cat $DEV/modalias`
> done

Yes, very nice :)

thaks,

greg k-h
