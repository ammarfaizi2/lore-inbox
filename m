Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFFTjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFFTjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:39:40 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:63493 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S262254AbTFFTjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:39:36 -0400
Date: Fri, 6 Jun 2003 20:53:08 +0100
From: Alasdair G Kergon <agk@uk.sistina.com>
To: dm-devel@sistina.com
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Message-ID: <20030606205308.B12727@uk.sistina.com>
Mail-Followup-To: dm-devel@sistina.com,
	Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <20030606171700.GC12231@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030606171700.GC12231@kroah.com>; from greg@kroah.com on Fri, Jun 06, 2003 at 10:17:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 10:17:00AM -0700, Greg KH wrote:
> Minor comment:
> 	- please do not use uint_32t types in kernel header files.  Use
> 	  the proper __u32 type which is guarenteed to be the proper
> 	  size across the user/kernel boundry.

So is uint32_t:

    linux/types.h: typedef         __u32           uint32_t;

I think this comment is about style conformity i.e. most linux kernel
developers avoid these (not-so-)new and more-portable C99 types.

Alasdair
-- 
agk@uk.sistina.com

Refs. http://www.xml.com/ldd/chapter/book/ch10.html
      http://www.unix-systems.org/whitepapers/64bit.html
