Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136581AbREJM7n>; Thu, 10 May 2001 08:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136247AbREJM7h>; Thu, 10 May 2001 08:59:37 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47751 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136303AbREJM7W>;
	Thu, 10 May 2001 08:59:22 -0400
Date: Wed, 9 May 2001 22:24:56 -0700
From: Greg KH <greg@kroah.com>
To: clameter@lameter.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <20010509222456.A4960@kroah.com>
In-Reply-To: <20010509203259.B4685@kroah.com> <Pine.LNX.4.10.10105092307440.29655-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105092307440.29655-100000@melchi.fuller.edu>; from clameter@lameter.com on Wed, May 09, 2001 at 11:09:36PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:09:36PM -0700, clameter@lameter.com wrote:
> 
> Allright then you should first check why the ACM driver is unable to
> handle an MTU of 1500. I had to set it to 232 or 500 to make it work at
> all. With an MTU of 1500 it does ICMP but not long tcp packets. There is
> some issue with long packets that might exceed some buffer size(?).

I don't see anything in the ACM driver that would cause a problem for
large MTU settings.  It is probably a device limitation, not the driver.

greg k-h
