Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVG1MUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVG1MUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVG1MUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:20:09 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:27636 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261460AbVG1MTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:19:06 -0400
Message-ID: <42E8CD48.7090008@gentoo.org>
Date: Thu, 28 Jul 2005 13:19:20 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Fieroch <fieroch@web.de>
Cc: linux-kernel@vger.kernel.org, linux@syskonnect.de
Subject: Re: driver for Marvell 88E8053 PCI Express Gigabit LAN
References: <dc9252$tgr$1@sea.gmane.org> <dc94v3$40c$1@sea.gmane.org>
In-Reply-To: <dc94v3$40c$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Alexander Fieroch wrote:
> Alexander Fieroch wrote:
> 
>> http://dlsvr01.asus.com/pub/ASUS/lan/marvell/8053/8053_others2.zip
> 
> 
> Oh, that driver is very old. Here is the latest one which is working 
> with the current kernel:
> 
> http://www.syskonnect.de/syskonnect/support/driver/htm/sk9elin.htm
> 
> Could you please integrate it to the kernel?

Syskonnect's latest changes to the sk98lin driver do not adhere to Linux 
coding standards -- they have basically crammed two drivers into one in an 
ugly fashion. It won't be included in the mainline kernel in this form.

Part of sk98lin has been rewritten as skge (this supports the Yukon-based PCI 
adapters) which will be included in 2.6.13.

In order to support the newer Yukon-II (PCI express) adapters in an acceptable 
fashion, a new driver will need to be written, skge-style. I don't think this 
is in development just yet. Perhaps you could try contacting 
Syskonnect/Marvell yourself to get them to help out developing a driver fit 
for inclusion.

Daniel
