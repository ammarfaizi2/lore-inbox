Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311495AbSCNDQI>; Wed, 13 Mar 2002 22:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311497AbSCNDQC>; Wed, 13 Mar 2002 22:16:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8206 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311495AbSCNDPp>;
	Wed, 13 Mar 2002 22:15:45 -0500
Message-ID: <3C9015D2.4060108@mandrakesoft.com>
Date: Wed, 13 Mar 2002 22:15:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <E16lLnM-0008E8-00@the-village.bc.nu> <20020313191159.B14095@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:

>1) Most Wireless LAN driver live outside the kernel. So, their
>evolution is somewhat decoupled to the kernel, so the earlier the
>patch goes it the better it is for those.
>
As you may have gathered from my last email, this is a bit annoying when 
trying to find and stabalize a driver for a card you just got :)

>	2) David Gibson, maintainer of the Orinoco driver, told me
>that he would merge my new-API orinoco patches in his driver only when
>the new API would be in 2.4.x (as you may have noticed, he hasn't
>updated 2.5.X for a while). Chicken and Eggs.
>
Does that mean orinoco updates are coming for 2.5.x?

Any idea if the other drivers are getting updates too, like airo?

>I'm open to suggestions and will do what's best for
>everybody. What other people think ?
>	But I feel now is a good time (as it seem that 2.4.19 will
>have to go through some stabilisation process).
>
My standard rule of thumb is turning out to be, deploy something 
2.4.x-worthy in 2.5.x, wait a while, and then deploy it in 2.4.x.  I 
have no particular opinion about whether your patch should go in -right 
now- but it seems like a fair patch for 2.4.x sooner or later.

    Jeff





