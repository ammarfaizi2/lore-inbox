Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSKUXuM>; Thu, 21 Nov 2002 18:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSKUXuM>; Thu, 21 Nov 2002 18:50:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12427 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267210AbSKUXuL>; Thu, 21 Nov 2002 18:50:11 -0500
Subject: Re: Setting MAC address in ewrk3 driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Neil Cafferkey <caffer@cs.ucc.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121233950.GB4654@www.kroptech.com>
References: <20021121195417.A18859@cuc.ucc.ie>
	<1037914095.9122.0.camel@irongate.swansea.linux.org.uk> 
	<20021121233950.GB4654@www.kroptech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 00:26:16 +0000
Message-Id: <1037924776.9122.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 23:39, Adam Kropelin wrote:
> Alan, could you clarify for me? I'm the last guy to diddle with ewrk3 so
> I'll track this down if there is indeed something to track down. ewrk3
> has a private ioctl for setting the mac address. By the "up" method do
> you mean the etherdev open method? Should there be a standard ioctl
> implemented for setting the mac address?

dev->set_mac_address()


