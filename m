Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWKREVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWKREVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWKREVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:21:54 -0500
Received: from main.gmane.org ([80.91.229.2]:61846 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752041AbWKREVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:21:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: FW: RTC , ds1307 I2C driver and NTP does not work.
Date: Sat, 18 Nov 2006 04:21:43 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelt308.dd3.olecom@flower.upol.cz>
References: <F6AD7E21CDF4E145A44F61F43EE6D939AF4560@tmnt04.transmode.se>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: 
> Sent: 17 November 2006 17:57
> To: Joakim Tjernlund
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: RTC , ds1307 I2C driver and NTP does not work.
>
>
> On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:
>
>> I get this when I activathte NTP and ntp "sync" the time the I2C HW  
>> clock.
>
> You may be better off posting this to lkml and copy the i2c list (and  
> rtc if one exists).  Since its more a driver issue than anything  
> really ppc specific.  Clearly we are doing schedules() in mpc_xfer()  
> and maybe we shouldn't be.
>
> - kumar

Please try this patch:
<http://permalink.gmane.org/gmane.linux.kernel/467686>
Message-ID: <200611162327.37306.david-b@pacbell.net>
____

