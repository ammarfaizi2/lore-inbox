Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWGKXX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWGKXX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWGKXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:23:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:8872 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932235AbWGKXW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:22:59 -0400
Date: Tue, 11 Jul 2006 15:59:09 -0700
From: Greg KH <greg@kroah.com>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, efault@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled /sbin/ifup
Message-ID: <20060711225909.GK18838@kroah.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <1152469329.9254.15.camel@Homer.TheSimpsons.net> <20060709135148.60561e69.akpm@osdl.org> <20060709.173212.112177014.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060709.173212.112177014.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 05:32:12PM -0700, David Miller wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Sun, 9 Jul 2006 13:51:48 -0700
> 
>  ...
> > > As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
>  ...
> > I'd be suspecting
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.
> 
> Oh well, it means we can't apply that patch as it does break
> things.

Ugh, that stinks.  I'll work on fixing up those helper applications so
this doesn't happen, and try to get an update into the 10.1 pipeline

So, I guess I'll just carry this forward for the next 6 months or so
till SuSE 10.0 support goes away.

> Greg, do you test on SuSE installations? :-)

Heh, most of the time yes, but this stuff only on a Gentoo box for some
reason.  Sorry about that.

thanks,

greg k-h
