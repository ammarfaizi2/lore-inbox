Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWBTNCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWBTNCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWBTNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:02:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16393 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932613AbWBTNCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:02:15 -0500
Date: Mon, 20 Feb 2006 13:02:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: David Vrabel <dvrabel@cantab.net>, Adrian Bunk <bunk@stusta.de>,
       Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
Subject: Re: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values: maclist
Message-ID: <20060220130203.GA22147@flint.arm.linux.org.uk>
Mail-Followup-To: Alessandro Zummo <alessandro.zummo@towertech.it>,
	David Vrabel <dvrabel@cantab.net>, Adrian Bunk <bunk@stusta.de>,
	Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, John Bowler <jbowler@acm.org>
References: <20060220010113.GA19309@deprecation.cyrius.com> <20060220014735.GD4971@stusta.de> <20060220030146.11f418dc@inspiron> <43F9B32B.3090203@cantab.net> <20060220135718.038b675b@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220135718.038b675b@inspiron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:57:18PM +0100, Alessandro Zummo wrote:
>   you're certainly right on the ixp4xx, but the are other uses
>  for this driver which we are working on.. for example,
>  some Cirrus Logic ARM based chips (ep93xx) have an ethernet device
>  that could benefit from that.

An alternative solution (suggested in the past) would be to have a
generic kernel command line option such as: mac=<netdev>,<macaddr>

It nicely solves the "no mac address" issue in a lot (if not all)
of the cases.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
