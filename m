Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTBTV0j>; Thu, 20 Feb 2003 16:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTBTV0j>; Thu, 20 Feb 2003 16:26:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19077
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266994AbTBTV0i>; Thu, 20 Feb 2003 16:26:38 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
In-Reply-To: <20030220211941.GD13216@unthought.net>
References: <1045106216.1089.16.camel@vmhack>
	 <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz>
	 <1045260726.1854.7.camel@irongate.swansea.linux.org.uk>
	 <20030214213542.GH23589@atrey.karlin.mff.cuni.cz>
	 <1045264651.13488.40.camel@vmhack>
	 <1045274042.2961.4.camel@irongate.swansea.linux.org.uk>
	 <1045632256.2974.76.camel@vmhack>  <20030220211941.GD13216@unthought.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045780613.3790.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 22:36:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 21:19, Jakob Oestergaard wrote:
> I know that there is ioctl support in the existing drivers - but I have
> not yet seen a driver which needed it.   "needed" in the sense that
> equivalent functionality could not have been created using dev files
> alone.
> 
> Also, the amount of userspace which will break because of missing ioctl
> functionality will be absolutely *minimal*.  There's not a lot of
> watchdog software out there, and porting whatever software uses ioctls
> to use sane interfaces instead, should be doable.  I don't think anyone
> would get terribly upset if this change was made as a 2.4->2.6
> transition thing.

There is a lot of watchdog using stuff, some quite proprietary and 
embedded into big apps. Even then you have to solve the persistence
issue.

Losing the old api is a 2.8/3.0 thing perhaps, even then its a big
break by Linux standards

