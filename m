Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291103AbSBGEXt>; Wed, 6 Feb 2002 23:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291099AbSBGEXj>; Wed, 6 Feb 2002 23:23:39 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:11441 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291103AbSBGEX1>;
	Wed, 6 Feb 2002 23:23:27 -0500
Message-ID: <3C620131.9090606@candelatech.com>
Date: Wed, 06 Feb 2002 21:23:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <200202070151.g171p4h11574@moisil.badula.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>>From the limited testing I just ran, I appears that starfire and 3c59x 
> handle this correctly, whereas tulip always loses a small number of 
> packets during a UDP storm. ttcp -us[rt] is very useful for such 
> testing...


It would be interesting to see which side is dropping?  Have you
coorelated ethernet driver counters to your sendto count?


> 
> Ion
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


