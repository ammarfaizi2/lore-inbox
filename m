Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319754AbSIMTNx>; Fri, 13 Sep 2002 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319756AbSIMTNx>; Fri, 13 Sep 2002 15:13:53 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:9661 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319754AbSIMTNv>;
	Fri, 13 Sep 2002 15:13:51 -0400
Subject: Re: 2.4.20pre5aa2
From: Stephen Lord <lord@sgi.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <3D813CFB.7050200@rackable.com>
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
	<1031768655.24629.23.camel@UberGeek.coremetrics.com>
	<20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com>
	<20020913002316.GG11605@dualathlon.random>  <3D813CFB.7050200@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 13 Sep 2002 14:17:42 -0500
Message-Id: <1031944671.1534.34.camel@snafu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 20:18, Samuel Flory wrote:
> 
>    The system has 4G of ram, and 4G of swap.  So real memory is not an 
> issue.  The system is a intended to be an nfs server.   As a result nfs 
> performance is my only real concern.  I should really use CONFIG_3GB as 
> I'm not doing much in user space other a tftp, and dhcp server.
> 
>    In any case the system isn't in production so I can leave it as is 
> till monday.
> 

So, after backing out  00_net-softirq (this was killing my networking
and NFS setup for some reason) and applying the new scheduler
related fix in xfs, I have had this kernel up a few hours running
dbench and a bunch of other things, it has not hung once or exhibited
any other problems.

Having said that, my environment is different, I do not have 4G of
memory, I have 128M, and I also do not have md - not enough disks
right now to do that.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

