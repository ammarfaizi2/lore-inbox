Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVAFUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVAFUDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVAFUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:01:55 -0500
Received: from smtp.terra.es ([213.4.129.129]:4979 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S263001AbVAFT7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:59:05 -0500
Date: Thu, 6 Jan 2005 20:58:56 +0100
From: Diego Calleja <diegocg@teleline.es>
To: Adrian Bunk <bunk@stusta.de>
Cc: paolo.ciarrocchi@gmail.com, tytso@mit.edu, davidsen@tmr.com,
       diegocg@teleline.es, willy@w.ods.org, wli@holomorphy.com,
       aebr@win.tue.nl, solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-Id: <20050106205856.456d211b.diegocg@teleline.es>
In-Reply-To: <20050106193214.GK3096@stusta.de>
References: <20050103134727.GA2980@stusta.de>
	<Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com>
	<20050103183621.GA2885@thunk.org>
	<4d8e3fd30501060603247e955a@mail.gmail.com>
	<20050106193214.GK3096@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 6 Jan 2005 20:32:14 +0100 Adrian Bunk <bunk@stusta.de> escribió:

> If a security vulnerability was found today, this meant backporting and 
> applying the patch to 11 different kernel versions, the oldest one being 
> more than one year old.


Personally I'd be happier if security issues would trigger a new release. I
mean, if a security issue shows up in 2.6.10, release 2.6.11, with 2.6.11
being 2.6.10 + the patch for the security issues, and at the same time
release 2.6.12-rcwhatever with all the patches that were going to 
be 2.6.11. Marcelo has done this at least one time in 2.4, but in 2.6
serious issues have been found and the patch has been available for weeks
but the "latest stable version" in kernel.org didn't have the patch for that
time. 

Vendors will fix it themselves true, but lots of people still use whatever
it's available at kernel.org, and linux always will be that way (hopefully),
so it'd be nice to get fast "official" updates to those issues. Currently,
you've to patch it yourself, and for that you usually have to read it in 
some linux news page and extract the patch from a lkml mirror (kernel.org
don't warns of any security issue at all) so lots of people don't notice that
there's any security issue because currently there's no way of notifying them.
However a new kernel release would have the desired effect - the user updates
his kernel because he knows there's something to fix.

And if nobody wants those "security-only" releases at least a special section
in kernel.org would be nice, slashdot is not really a good way to get
security notifications and not all people wants to subscribe to a mailing
list.
