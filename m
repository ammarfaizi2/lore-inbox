Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUGPRMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUGPRMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUGPRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:10:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20407 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266604AbUGPRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:10:38 -0400
Date: Fri, 16 Jul 2004 19:07:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
Message-ID: <20040716170716.GD8264@openzaurus.ucw.cz>
References: <10898500322333@kroah.com> <10898500321009@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10898500321009@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +menu "Dallas's 1-wire bus"
> +
> +config W1
> +	tristate "Dallas's 1-wire support"
> +	---help---
> +	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
> +	  such as iButtons and thermal sensors.

Just out of curiosity... are such devices really connected using one wire only,
or is it GND+5V+one data wire, or GND+power&data wire?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

