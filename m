Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbTDKWvg (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDKWvg (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:51:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45217 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261952AbTDKWvd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:51:33 -0400
Date: Fri, 11 Apr 2003 16:05:33 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411230533.GH3786@kroah.com>
References: <20030411173018$2695@gated-at.bofh.it> <20030411175011$3d7e@gated-at.bofh.it> <20030411182022$7f7a@gated-at.bofh.it> <20030411184016$1180@gated-at.bofh.it> <20030411204006$0496@gated-at.bofh.it> <20030411205018$7440@gated-at.bofh.it> <200304112111.h3BLBWgu025834@post.webmailer.de> <3E974348.7080104@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E974348.7080104@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:35:52PM -0700, Steven Dake wrote:
> Yes, and in the rest of my email, I stated this would be solved by 
> replacing /sbin/hotplug with a mechanism to communicate events to a user 
> space daemon which would process requests in order as submitted by the 
> kernel. (All except the same minor/major, which may or may not happen).  
> If the kernel is evil and doesn't submit events in order, thats another 
> problem to solve, but it should for disk events, atleast.

Multi-threaded device discovery is a good thing, it solves a lot of
real-life problems that we have today.  But it's a 2.7 thing, not on the
near horizon.

thanks,

greg k-h

Making the kernel evil since 2001
