Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJQRQK>; Thu, 17 Oct 2002 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSJQRPQ>; Thu, 17 Oct 2002 13:15:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261562AbSJQRO0>;
	Thu, 17 Oct 2002 13:14:26 -0400
Message-ID: <3DAEF15E.4030105@pobox.com>
Date: Thu, 17 Oct 2002 13:20:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
References: <200210171714.KAA02527@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	I believe that there are motherboards that use a chipset from
> Compaq that allows hot plugging and unplugging of ordinary PCI cards,
> supported by drivers in linux-2.5.43/drivers/hotplug/cpq*.[ch].  At a
> trade show, I saw a demo of a motherboard with such a capability (not
> running Linux, but I think from Compaq).


You are correct that all PCI cards are now hotpluggable.

My position is that _my_ driver will not be converted to be hotpluggable 
until someone actually does so.  Until such a time, I prefer the space 
savings that keeping it non-hotplug-able provides.

	Jeff



