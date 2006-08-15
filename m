Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWHOSPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWHOSPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWHOSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:15:36 -0400
Received: from s2.yuriev.com ([69.31.8.140]:32436 "HELO s2.yuriev.com")
	by vger.kernel.org with SMTP id S1030433AbWHOSPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:15:35 -0400
Date: Tue, 15 Aug 2006 14:06:34 -0400
From: alex@yuriev.com
To: Mark Reidenbach <m.reidenbach@everytruckjob.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Message-ID: <20060815180634.GB15957@s2.yuriev.com>
References: <44E1F0CD.7000003@everytruckjob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E1F0CD.7000003@everytruckjob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After scouring the net for many days trying to find an answer as to how 
> to find the broken router, I've come up empty and there are many 
> references as to why you don't want to disable window scaling completely 
> which so far has been my only working solution.   Can anyone give 
> instructions or references as to what the requirements are for a router 
> to work (specifically Cisco routers)?  Is there a minimum required IOS 
> or certain commands that must be enabled such as any of the following?
> ip tcp window-size 8388480
> ip tcp selective-ack
> ip tcp timestamp
> 

This is absolutely not correct. Routers forward packets. They do not mangle
the data in them.

Alex

