Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268330AbUIWI7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268330AbUIWI7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIWI7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:59:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:38059 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268330AbUIWI7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:59:35 -0400
Date: Thu, 23 Sep 2004 10:57:14 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys: Network device status: link; Hard disks?
In-Reply-To: <20040922153028.11a85771@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0409231055160.15793@jjulnx.backbone.dif.dk>
References: <20040922141630.GE694@schottelius.org>
 <Pine.LNX.4.61.0409221616561.14486@jjulnx.backbone.dif.dk>
 <20040922222545.GA1442@schottelius.org> <20040922153028.11a85771@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Stephen Hemminger wrote:

> Date: Wed, 22 Sep 2004 15:30:28 -0700
> From: Stephen Hemminger <shemminger@osdl.org>
> To: linux-kernel@vger.kernel.org
> Subject: Re: /sys: Network device status: link; Hard disks?
> 
> You probably just want to expose the state of netif_carrier_ok (and netif_running).
> Doing it in net-sysfs.c is trivial.  I was hoping someone else would learn something
> and do it for me.

That is exactely what I've started to do, but it's taking me a little 
while since I have limited time and have to learn about sysfs first. But 
it's a nice learning experience and I'll post a patch as soon as I have 
something that works resonably, but it might take me a few days.


--
Jesper Juhl

