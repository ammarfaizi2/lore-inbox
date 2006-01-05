Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWAEVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWAEVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWAEVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:04:58 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:62648 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S932191AbWAEVE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:04:57 -0500
Date: Thu, 5 Jan 2006 22:04:44 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060105210444.GA5878@xi.wantstofly.org>
References: <20060105181826.GD12313@stusta.de> <43BD6C03.2080605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD6C03.2080605@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:57:07PM -0500, Jeff Garzik wrote:

> >This patch removes the obsolete drivers/net/eepro100.c driver.
> >
> >Is there any known problem in e100 still preventing us from removing 
> >this driver (it seems noone was able anymore to verify the ARM problem)?
> 
> Still waiting to see if e100 in -mm works on ARM.

e100 seems to work okay on the (modern) ARM CPUs I've tried.  The case
where e100 failed but eepro100 worked was (I think) on older ARM hardware,
and I'm not sure whether that kind of hardware is used anymore..


cheers,
Lennert
