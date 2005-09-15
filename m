Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbVIOHK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbVIOHK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIOHK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:10:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33040 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030438AbVIOHKU (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:10:20 -0400
Date: Thu, 15 Sep 2005 08:10:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, zippel@linux-m68k.org,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
Message-ID: <20050915081009.A3739@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	nickpiggin@yahoo.com.au, zippel@linux-m68k.org,
	Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
References: <Pine.LNX.4.61.0509141829050.3743@scrub.home> <432854B6.1020408@yahoo.com.au> <20050914230352.G30746@flint.arm.linux.org.uk> <20050914.152610.15194310.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050914.152610.15194310.davem@davemloft.net>; from davem@davemloft.net on Wed, Sep 14, 2005 at 03:26:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 03:26:10PM -0700, David S. Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Wed, 14 Sep 2005 23:03:53 +0100
> 
> > What business has userspace got of telling whether cmpxchg works on
> > an architecture by looking at kernel headers?
> 
> Russell, please don't fly off the handle like this.

Sigh, I wasn't.  I was making a valid point.  Maybe if you read the
bit I quoted you'd have realised that, which was:

> I think userspace synchronization may be quite a valid use of
          ^^^^^^^^^
> atomic cmpxchg, but Kconfig is a far better place to do it than
> testing HAVE_ARCH_CMPXCHG.

But maybe I'm not capable of interpreting the above english?  To
me at least it's definitely talking about user space, not kernel
space.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
