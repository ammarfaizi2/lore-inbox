Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313705AbSDQI2b>; Wed, 17 Apr 2002 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314087AbSDQI2a>; Wed, 17 Apr 2002 04:28:30 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:25056 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S313705AbSDQI2a>; Wed, 17 Apr 2002 04:28:30 -0400
Date: Wed, 17 Apr 2002 10:28:28 +0200
From: bert hubert <ahu@ds9a.nl>
To: Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
Subject: please merge 64-bit jiffy patches. Was Re: Why HZ on i386 is 100 ?
Message-ID: <20020417102828.D11817@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl> <20020416233457.A1731@outpost.ds9a.nl> <20020416222156.GB20464@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 10:24:26PM +0000, Andreas Dilger wrote:

> Trivially fixed with the existing 64-bit jiffies patches.  As it is,
> your uptime wraps to zero after 472 days or something like that if you
> don't have the 64-bit jiffies patch, which is totally in the realm of
> possibility for Linux servers.

I feel your pain 

4:26am  up 482 days, 10:33,  2 users,  load average: 0.04, 0.02, 0.00

On a very remote server.

So can we please merge the 64-bit jiffies patches? I sometimes think that
that is the main reason why alpha DOES have HZ=1024 - the jiffies there
don't wrap in an embarrassing way within two months :-)

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
