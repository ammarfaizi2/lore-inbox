Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWGaTK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWGaTK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWGaTK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:10:26 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:11793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030335AbWGaTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:10:24 -0400
Date: Mon, 31 Jul 2006 20:10:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, Komal Shah <komal_shah802003@yahoo.com>,
       akpm@osdl.org, gregkh@suse.de, i2c@lm-sensors.org, imre.deak@nokia.com,
       juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org,
       r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-ID: <20060731191001.GA10489@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Jean Delvare <khali@linux-fr.org>,
	Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org,
	gregkh@suse.de, i2c@lm-sensors.org, imre.deak@nokia.com,
	juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org,
	r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607310733.09125.david-b@pacbell.net> <20060731181327.d54ce1d0.khali@linux-fr.org> <200607310941.01340.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607310941.01340.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:41:00AM -0700, David Brownell wrote:
> On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
> > Hi David,
> > 
> > > And I **really** hope this gets merged into 2.6.18 since virtually
> > > no OMAP board is very usable without it.  I2C is one of the main
> > > missing pieces(*) ... can whoever's managing I2C merges please
> > > expedite this?

Slightly off-topic, and probably not your area, but it would probably
help your case if omap were better looked after in mainline.  Most OMAP
platforms build fine, except for one long standing one - the H2 1610
defconfig, which hasn't built since 2.6.17-git11.

So, rather than shoveling new stuff in there, can the maintainence of
the stuff already merged please be improved.

Build results vs kernel version for H2 1610:

http://armlinux.simtec.co.uk/kautobuild/omap_h2_1610_defconfig.html

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
