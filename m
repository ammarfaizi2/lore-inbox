Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263732AbUJ3Ah7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbUJ3Ah7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263739AbUJ3AeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:34:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:1669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263768AbUJ3Abe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:31:34 -0400
Message-ID: <4182DFAE.7000409@osdl.org>
Date: Fri, 29 Oct 2004 17:26:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: kj <kernel-janitors@osdl.org>, linux-kernel@vger.kernel.org,
       Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [KJ] 2.6.10-rc1-kjt1: ixgb_ethtool.c doesn't compile
References: <20041024151241.GA1920@stro.at> <20041029235137.GG6677@stusta.de>
In-Reply-To: <20041029235137.GG6677@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Oct 24, 2004 at 05:12:41PM +0200, maximilian attems wrote:
> 
>>...
> 
> 
> msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch doesn't 
> compile:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/net/ixgb/ixgb_ethtool.o
> drivers/net/ixgb/ixgb_ethtool.c: In function `ixgb_ethtool_led_blink':
> drivers/net/ixgb/ixgb_ethtool.c:407: error: `id' undeclared (first use in this function)
> drivers/net/ixgb/ixgb_ethtool.c:407: error: (Each undeclared identifier is reported only once
> drivers/net/ixgb/ixgb_ethtool.c:407: error: for each function it appears in.)
> make[3]: *** [drivers/net/ixgb/ixgb_ethtool.o] Error 1
> 
> <--  snip  -->

There are new (large) patches to the ixgb driver too.  See:
http://oss.sgi.com/projects/netdev/archive/2004-10/msg01342.html


-- 
~Randy
