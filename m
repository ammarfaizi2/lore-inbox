Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVILQuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVILQuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVILQuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:50:09 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:28824 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932076AbVILQuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:50:08 -0400
Message-ID: <4325B1C0.80405@gentoo.org>
Date: Mon, 12 Sep 2005 17:50:08 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com> <43244C33.1050502@gentoo.org> <dg1s37$kd4$1@sea.gmane.org> <dg48qi$p96$1@sea.gmane.org>
In-Reply-To: <dg48qi$p96$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Well, I did test it, but skge didn't even find the hardware :-(
> No device was created, no dmesg output on load.
> Instead I am running 2.6.13.1 with sk98lin-8.23.1.3.patch
> The MB is ASUS P5GDC-V-Deluxe and the the on-board NIC:
> 
> # lspci -v  -s 02:00.0
> 0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 
> Gigabit Ethernet Controller (rev 15)

This patch was to solve an issue in skge, a driver for Marvell Yukon network 
adapters.

Your hardware is a yukon-2 adapter, you want to use the sky2 driver from the 
netdev tree.

Daniel
