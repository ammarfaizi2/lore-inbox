Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSEVOIk>; Wed, 22 May 2002 10:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSEVOIj>; Wed, 22 May 2002 10:08:39 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:58573 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S314067AbSEVOIi>;
	Wed, 22 May 2002 10:08:38 -0400
Date: Wed, 22 May 2002 16:08:39 +0200
From: bert hubert <ahu@ds9a.nl>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <20020522140839.GA9903@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020522085111.C20554@ds217-115-141-141.dedicated.hosteurope.de> <HBEHIIBBKKNOBLMPKCBBGEBEENAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 07:00:11AM -0700, M. Edward Borasky wrote:
> A few months ago, there was a flurry of reports from people having
> difficulties with memory management on large machines (ia32 over 4 GB). I've
> seen a lot of 2.4.x-yy kernels go by and much VM discussion, but what I'm
> *not* seeing is reports of either catastrophic behavior or its absence on
> large machines. I haven't had a chance to run my own test cases on the
> 2.4.18 kernel from Red Hat 7.3 yet, so I can't make any personal
> contribution to this discussion.

RedHat has fixed the problem in its kernels. There are fixes out there, but
Linus is not applying them. I would venture that this is because they would
fix the problems *for the moment* and take away interest in revamping VM for
real.

It might help if Linus would actually state his intentions. So far the
problem has been that the AA vm was badly documented and a big chunk of
patches. Andrew Morton split them up nicely and documented each patch, so
that is resolved.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
