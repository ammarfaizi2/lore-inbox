Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCADrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCADrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 22:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCADrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 22:47:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16097 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261226AbVCADrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 22:47:04 -0500
Message-ID: <4223E59D.3060902@pobox.com>
Date: Mon, 28 Feb 2005 22:46:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disallow modular framebuffers
References: <20050301024118.GF4021@stusta.de>
In-Reply-To: <20050301024118.GF4021@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi,
> 
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and 
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> 
> Do modular framebuffers really make sense?
> 
> OK, distributions like to make everything modular, but all the 
> framebuffer drivers I've looked at parse driver specific options in 
> their *_setup function only in the non-modular case.
> 
> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?


It depends on the driver's level of hardware support, and the likely 
configuration of the hardware at boot time.

It is a case-by-case basis.

	Jeff


