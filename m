Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261589AbSI0Awv>; Thu, 26 Sep 2002 20:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSI0Awv>; Thu, 26 Sep 2002 20:52:51 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:56816 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261589AbSI0Awu>; Thu, 26 Sep 2002 20:52:50 -0400
Date: Thu, 26 Sep 2002 20:58:08 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] High-res-timers part 1 (core)
Message-ID: <20020926205808.A15402@redhat.com>
References: <3D93A363.ACA56815@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D93A363.ACA56815@mvista.com>; from george@mvista.com on Thu, Sep 26, 2002 at 05:16:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:16:35PM -0700, george anzinger wrote:
> hash list.  This change makes it easy to configure the list
> size for those who are concerned with performance.  It also
> eliminates the "time out" for the cascade operation every

Could you make the list size configurable at boot time or by sysctl?  
It's almost impossible for distro vendors to get these kinds of tunables 
right for everyone, so making them dynamic is preferred.

		-ben
