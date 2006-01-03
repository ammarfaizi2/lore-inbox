Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWACLUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWACLUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWACLUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:20:51 -0500
Received: from web32902.mail.mud.yahoo.com ([68.142.206.49]:9378 "HELO
	web32902.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751226AbWACLUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:20:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GjRJ5pE/QUtvIh/HdwYNw7pTwPN52AGu5SD4HDGR6T0uS6mpdL7KyseoyNZ3BwLvQE6WIM6prH3ysGjK1RNrNUgIV7a1J7epW3MzlCvNXAy9GLn83G9tg1rEFFYWz58Upvp0x0sI2X6H7Fr/n/QC+e/tKDfDexP6/nl8vRCGjxg=  ;
Message-ID: <20060103112047.33558.qmail@web32902.mail.mud.yahoo.com>
Date: Tue, 3 Jan 2006 03:20:47 -0800 (PST)
From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [spi-devel-general] [patch 2.6.14-rc6-git 2/6] SPI ads7846 protocol driver
To: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: spi-devel-general@lists.sourceforge.net
In-Reply-To: <200512221538.33673.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Brownell <david-b@pacbell.net> wrote:

> For touchscreen plus sensors.  Lots of Linux-capable boards have
> these chips
> or one of their close siblings.
> > This is a driver for the ADS7846 touchscreen sensor, derived from
> the corgi_ts and omap_ts drivers.  Key differences from those two:
> 
>   - Uses the new SPI framework (minimalist version)
>   - <linux/spi/ads7846.h> abstracts board-specific touchscreen info
>   - Sysfs attributes for the temperature and voltage sensors
>   - Uses fewer ARM-specific IRQ primitives

How do you test this driver on OSK? Don't we need controller driver /
bitbanging interface atleast?

Also use input_allocate_device() instead of init_input_dev(). Thanx.

I have started writing OMAP2 SPI master controller driver for and
tsc2101 driver based on ads7846 driver for H4 board.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
