Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTFITtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFITtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:49:40 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:27622 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261216AbTFITtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:49:39 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: dm-devel@sistina.com, Greg KH <greg@kroah.com>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [dm-devel] Re: [RFC] device-mapper ioctl interface
Date: Mon, 9 Jun 2003 22:03:50 +0200
User-Agent: KMail/1.5.2
Cc: dm-devel@sistina.com, Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030605093943.GD434@fib011235813.fsnet.co.uk> <20030606171700.GC12231@kroah.com>
In-Reply-To: <20030606171700.GC12231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306092203.50024.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 June 2003 19:17, Greg KH wrote:
> On Thu, Jun 05, 2003 at 10:39:43AM +0100, Joe Thornber wrote:
> > Here's the header file for the the proposed new ioctl interface for
> > dm.  We've tried to change as little as possible to minimise code
> > changes in LVM2 and EVMS.
>
> Minor comment:
> 	- please do not use uint_32t types in kernel header files.  Use
> 	  the proper __u32 type which is guarenteed to be the proper
> 	  size across the user/kernel boundry.

We even have a flavor without the __'s:

   http://lxr.linux.no/source/include/asm-i386/types.h?v=2.5.56#L47

A little easier on the eyes, imho.

Regards,

Daniel

