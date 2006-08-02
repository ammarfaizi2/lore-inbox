Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWHBH1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWHBH1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWHBH1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:27:54 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:1296 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751328AbWHBH1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:27:53 -0400
Date: Wed, 2 Aug 2006 09:27:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060802092759.66aa23c4.khali@linux-fr.org>
In-Reply-To: <200607311713.09820.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200607310941.01340.david-b@pacbell.net>
	<20060731212532.810a39f8.khali@linux-fr.org>
	<200607311713.09820.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> > The "and could be patched later" way has been tried before, and I'm not
> > going there again. Later happened to be "never" or at least "too late"
> > more often than not.
> 
> Well, you've seen my basic review.  As for "later", it's quite routine;
> that's what "submit early and often" means.  That whole ext4 devel
> cycle depends on using "later" intelligently.

Releasing "early and often" was never an excuse to release buggy code.
It is (to me, at least) about adding functionalities one at a time,
rather than waiting to be full-featured before releasing first.

As for the "later", there are areas where it is known not to work, e.g.
documentation - or more generally, everything which is optional from a
functional point of view. I do expect functional bugs to be fixed
later when they bite the users, but I am more skeptical about cleanups
and documentation.

-- 
Jean Delvare
