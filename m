Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSGDVeU>; Thu, 4 Jul 2002 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSGDVeT>; Thu, 4 Jul 2002 17:34:19 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:42371 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S314325AbSGDVeT>;
	Thu, 4 Jul 2002 17:34:19 -0400
Date: Thu, 4 Jul 2002 23:36:52 +0200
From: bert hubert <ahu@ds9a.nl>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make a kernel thread sleep for a short amount of time?
Message-ID: <20020704213652.GA24947@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D24BC95.3030006@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D24BC95.3030006@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 02:22:29PM -0700, Ben Greear wrote:

> I believe the answer may be to use some sort of timer and have my
> thread sleep on this timer, but I cannot find any examples or
> documentation on how to do this on the web.

The only generally available timer is the timer interrupt, sadly, which
ticks once every 10ms (or soon once every ms, according to Linus' bitkeeper
tree) on i386.

At OLS I was told of the existence of 'firm timers':
http://www.cse.ogi.edu/~luca/firm.html

These might have use in the shaping world too.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
