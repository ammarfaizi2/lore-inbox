Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWGLG3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWGLG3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGLG3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:29:21 -0400
Received: from soundwarez.org ([217.160.171.123]:55722 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751355AbWGLG3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:29:20 -0400
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled
	/sbin/ifup
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060711225909.GK18838@kroah.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <1152469329.9254.15.camel@Homer.TheSimpsons.net>
	 <20060709135148.60561e69.akpm@osdl.org>
	 <20060709.173212.112177014.davem@davemloft.net>
	 <20060711225909.GK18838@kroah.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 08:29:24 +0200
Message-Id: <1152685764.4131.38.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 15:59 -0700, Greg KH wrote:
> On Sun, Jul 09, 2006 at 05:32:12PM -0700, David Miller wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > Date: Sun, 9 Jul 2006 13:51:48 -0700
> > 
> >  ...
> > > > As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
> >  ...
> > > I'd be suspecting
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.
> > 
> > Oh well, it means we can't apply that patch as it does break
> > things.
> 
> Ugh, that stinks.  I'll work on fixing up those helper applications so
> this doesn't happen, and try to get an update into the 10.1 pipeline
> 
> So, I guess I'll just carry this forward for the next 6 months or so
> till SuSE 10.0 support goes away.

Looks like an old version of libsysfs (1.3) is used and causes this
failure.

Kay

