Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbUCZMBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbUCZMBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:01:04 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:24790 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264020AbUCZL7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:59:49 -0500
Date: Fri, 26 Mar 2004 12:59:47 +0100
From: bert hubert <ahu@ds9a.nl>
To: Robert Schwebel <robert@schwebel.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326115947.GA22185@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Robert Schwebel <robert@schwebel.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040325221145.GJ10711@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325221145.GJ10711@pengutronix.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 11:11:45PM +0100, Robert Schwebel wrote:

> Unfortunately, although it works with the original Microsoft driver, you
> need an inf file on the windows side; you can download the template for
> that directly from M$. 

I don't understand this comment, it would probably be very wise to add
something to Documentation/ about this.

> -	.bDeviceClass =		DEV_CONFIG_CLASS,
> +	.bDeviceClass =		0x02,

Is this wise?

Thanks for this work, looks cool!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
