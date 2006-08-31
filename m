Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHaXjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHaXjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 19:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHaXjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 19:39:19 -0400
Received: from trinity.fluff.org ([217.147.94.151]:4321 "EHLO
	trinity.fluff.org") by vger.kernel.org with ESMTP id S1751232AbWHaXjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 19:39:18 -0400
Date: Fri, 1 Sep 2006 00:39:13 +0100
To: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] fix drivers/char/s3c2410-rtc.c: add missing base address
Message-ID: <20060831233913.GI3216@trinity.fluff.org>
References: <20060831221139.GA14511@g5.pc.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060831221139.GA14511@g5.pc.home>
X-Disclaimer: These are my views alone.
X-URL: http://www.fluff.org/
User-Agent: Mutt/1.5.9i
From: Ben Dooks <ben@trinity.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 12:11:39AM +0200, Luc Van Oostenryck wrote:
> Apply to drivers/char/s3c2410-rtc.c the same fix the commit
> 9a654518e1b774b8e8f74a819fd12a931e7672c9 did on drivers/rtc/rtc-s3c.c:
> prefix all the readb()/writeb() with the base address returned by ioremap()
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

Thanks, but this driver is scheduled for removal, and a patch has
been submitted to remove the driver.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

