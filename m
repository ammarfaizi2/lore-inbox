Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTAWWPx>; Thu, 23 Jan 2003 17:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAWWPx>; Thu, 23 Jan 2003 17:15:53 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:16122 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267204AbTAWWPw>; Thu, 23 Jan 2003 17:15:52 -0500
Date: Thu, 23 Jan 2003 14:24:42 -0800
From: Chris Wright <chris@wirex.com>
To: Daniel Khan <dk@webcluster.at>
Cc: linux-kernel@vger.kernel.org, linux-ha-dev@lists.community.tummy.com
Subject: Re: Ferquently system lockups under load
Message-ID: <20030123142442.A20877@figure1.int.wirex.com>
Mail-Followup-To: Daniel Khan <dk@webcluster.at>,
	linux-kernel@vger.kernel.org,
	linux-ha-dev@lists.community.tummy.com
References: <CGEAIHJJGFFOPODELPILOEIHDKAA.dk@webcluster.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CGEAIHJJGFFOPODELPILOEIHDKAA.dk@webcluster.at>; from dk@webcluster.at on Thu, Jan 23, 2003 at 02:30:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Khan (dk@webcluster.at) wrote:
> 
> The system:
> glibc-2.2.5-42
> heartbeat-0.4.9f-1
> RedHat 7.3 2.4.18-19.7.xsmp

There is a lockup issue with heartbeat 0.4.9f and current RH kernels.
It is typically exeperienced with the start up of apphbd, and appears to
be with realtime scheduled tasks.  Lars has posted a list of debugging
info he'd like to see on the linux-ha-dev list.  Check the recent archives
<http://lists.community.tummy.com/mailman/listinfo/linux-ha-dev>.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
