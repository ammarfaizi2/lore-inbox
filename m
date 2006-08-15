Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWHOQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWHOQlL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWHOQlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:41:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:672 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030385AbWHOQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:41:09 -0400
Subject: Re: How to find a sick router with 2.6.17+ and tcp_window_scaling
	enabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Reidenbach <m.reidenbach@everytruckjob.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44E1F0CD.7000003@everytruckjob.com>
References: <44E1F0CD.7000003@everytruckjob.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 18:01:47 +0100
Message-Id: <1155661308.24077.297.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 11:05 -0500, ysgrifennodd Mark Reidenbach:
> Does anyone have a way to find the broken router if you are not running 
> the networks involved?  

You are almost certainly looking for a broken/crap NAT box, firewall or
similar product. Routers that are just being routers don't touch the TCP
layer so even if they are broken/crap/ancient they won't do any harm to
it.

The usual offenders are cheap NAT boxes and badly designed load
balancers. They may not even show up in a trace but you should expect
them to be at one end or the other, unless your ISP is providing you
with NATted addresses or some kind of managed security service.

Alan
