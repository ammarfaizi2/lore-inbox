Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTIHT6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbTIHT6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:58:44 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:51905 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S263592AbTIHT5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:57:01 -0400
Message-ID: <3F5CDF74.7010406@terra.com.br>
Date: Mon, 08 Sep 2003 16:58:44 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Procter <rnp@paradise.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix SMP support on 3c527 net driver, take 2
References: <Pine.LNX.4.21.0309041758250.284-100000@ps2.local>	 <3F573574.5060008@terra.com.br> <1062681740.21994.48.camel@dhcp23.swansea.linux.org.uk> <3F573E0A.30406@terra.com.br>
In-Reply-To: <3F573E0A.30406@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Felipe W Damasio wrote:
>     So I think we can use something like the attached patch, then..which 
> get the lock before the while loop on mc32_interrupt and releases it 
> after processing the interrupts.
> 
>     Richard, could you please test it?

	Richard, did you test the driver with this last patch?

	If it fixes the SMP support correctly, then we can push it to Linus 
for merging on mainline.

	Thanks,

Felipe

