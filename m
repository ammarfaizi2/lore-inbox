Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTKIOrd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 09:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTKIOrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 09:47:33 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16320 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262540AbTKIOrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 09:47:32 -0500
Message-ID: <3FAE537E.4060907@colorfullife.com>
Date: Sun, 09 Nov 2003 15:47:26 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] forcedeth
References: <3FAE0D35.40908@colorfullife.com> <1068387273.14427.13.camel@midux>
In-Reply-To: <1068387273.14427.13.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:

>usually when I boot up it mount's the remote filesystems, now it just
>failed, and I tryed to ping lan/internet IP's they failed. And I noticed
>that none of my cards were working. this is the output of lspci for the
>card that works without forcedeth support in kernel and does not work if
>forcedeth is enabled: 
>01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
>RTL-8139/8139C/8139C+ (rev 10)
>That's the main card that I use for lan/internet. ifconfig in the other
>hand told me that I had two working cards. first on had ip 192.168.0.2
>(that's right) and the new card had 192.168.1.1.
>
Please compare the mac addresses listed by ifconfig: I guess that the 
nics changed their names, the nforce chip is now eth0 and the realtek is 
eth1, or vice versa.

--
    Manfred

