Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbTL2WuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTL2WuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:50:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:48331 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265159AbTL2WuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:50:18 -0500
Date: Mon, 29 Dec 2003 14:48:38 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 011 release
Message-ID: <20031229224838.GD13691@kroah.com>
References: <20031225005614.GA18568@kroah.com> <20031228020449.GA26527@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228020449.GA26527@werewolf.able.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 03:04:49AM +0100, J.A. Magallon wrote:
> 
> And a couple questions.
> a) Should not ordering be reversed here:
> 
>   start)
>     if [ ! -d $udev_dir ]; then
>         mkdir $udev_dir
>     fi
>     if [ ! -d $sysfs_dir ]; then
>         exit 1
>     fi
>   If we have not /sys, there's no sense on creating /udev, so I would check first
>   for /sys.

Care to send a patch?  :)

thanks,

greg k-h
