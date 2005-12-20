Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLTV4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLTV4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVLTV4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:56:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:25817 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932154AbVLTV4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:56:46 -0500
Date: Tue, 20 Dec 2005 13:56:17 -0800
From: Greg KH <greg@kroah.com>
To: gene.heskett@verizononline.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-ID: <20051220215616.GA4977@kroah.com>
References: <200512201505.43199.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512201505.43199.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 03:05:43PM -0500, Gene Heskett wrote:
> To whomever is in charge of the sensors code in the kernel:
> 
> I just noted that the temperatures being reported by gkrellm, using its 
> internal sensors stuff, are not correct by over 100F too low when -rc6 
> is running.  -rc5 seems to give good readings consistent with what 
> I've been observing for the last year, a slowly rising cpu reading due 
> to the zallman flower becoming dust packed, to the point of about 150F 
> for a normal reading.
> 
> Today, after rebooting to -rc6, I'm seeing cpu temps ranging between 
> 39.2 and 41.7 degress F. As the room is probably around 74F, thats a 
> bit of a dubious reading.
> 
> Whom do I contact about this? 

As per the MAINTAINERS file:
	HARDWARE MONITORING
	P:      Jean Delvare
	M:      khali@linux-fr.org
	L:      lm-sensors@lm-sensors.org
	W:      http://www.lm-sensors.nu/
	S:      Maintained

