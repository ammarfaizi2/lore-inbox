Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283719AbRLJUW4>; Mon, 10 Dec 2001 15:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286370AbRLJUWq>; Mon, 10 Dec 2001 15:22:46 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:10431 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S283719AbRLJUWh>;
	Mon, 10 Dec 2001 15:22:37 -0500
Message-ID: <3C15197C.7050708@candelatech.com>
Date: Mon, 10 Dec 2001 13:22:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTU vlan-related patch for tulip (2.4.x)
In-Reply-To: <20011210225759.B11450@stingr.net> <3C15146D.BA780B43@mandrakesoft.com> <3C1515E6.9C6EC26@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Becker once told me that there was no need to increase
the 1536 number (it is already plenty big, and has some extra space
in it already)...

Jeff Garzik wrote:

> To clarify, the patch takes PKT_BUF_SZ from (512*3) to (512*3)+4 which
> moves away from the nice multiple of a power-of-2 number.
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


