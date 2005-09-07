Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVIGBvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVIGBvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVIGBvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:51:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40682 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751167AbVIGBvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:51:37 -0400
Message-ID: <431E4799.7000502@pobox.com>
Date: Tue, 06 Sep 2005 21:51:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: pavel@ucw.cz, ipw2100-admin@linux.intel.com, pavel@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [patch 1/1] ipw2100: remove by-hand function entry/exit debugging
References: <200509062056.j86KuHcL031448@shell0.pdx.osdl.net>
In-Reply-To: <200509062056.j86KuHcL031448@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> From: Pavel Machek <pavel@ucw.cz>
> 
> This removes debug prints from entry/exit of functions.  Such level of
> debugging should probably be done by gdb or similar.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Cc: "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

NAK.  Rationale:  maintainer's choice.  Pavel doesn't get to choose the 
debugger of choice for the driver maintainer.

I do this entry/exit stuff in my net and SATA drivers; printk is my 
primary method of debugging.

	Jeff


