Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282728AbRK0B61>; Mon, 26 Nov 2001 20:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282727AbRK0B6S>; Mon, 26 Nov 2001 20:58:18 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:61617 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S282726AbRK0B6H>;
	Mon, 26 Nov 2001 20:58:07 -0500
Message-ID: <3C02F2A3.1090807@candelatech.com>
Date: Mon, 26 Nov 2001 18:55:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ben Greear <greearb@agcs.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
In-Reply-To: <Pine.GSO.3.96.1011126165647.21598T-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrm, not sure how this got through...but I'll sync down a clean 2.4.16
and test both types of compiles...

Thanks for the patch,
Ben

Maciej W. Rozycki wrote:

> Hi,
> 
>  It appears the 802.1Q VLAN support didn't receive even basic testing,
> sigh...  It doesn't compile non-modular, due to vlan_proc_cleanup() being
> discarded, yet needed in vlan_proc_init().  Following is a fix. 
> 
>   Maciej
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


