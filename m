Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286156AbRLJDmn>; Sun, 9 Dec 2001 22:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286159AbRLJDmc>; Sun, 9 Dec 2001 22:42:32 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:50356 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S286156AbRLJDmS>;
	Sun, 9 Dec 2001 22:42:18 -0500
Message-ID: <3C142F12.2040707@candelatech.com>
Date: Sun, 09 Dec 2001 20:42:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
In-Reply-To: <E167w6n-0001dz-00@fenrus.demon.nl> <3C0D54DF.4E897B70@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, I would see out-of-resource messages when I ran
50Mbps+ traffic + bonnie++ on a P-III 550Mhz machine.  With this patch,
I see no error messages, and traffic is flowing fine...

So, seems like a winner to me!

PS.  I don't currently have any machines available to test the
cmd-timeout issues with the eepro driver and some NICs.  Has
anyone tested to see if this patch actually fixes those problems too?

Thanks,
Ben

Tim Hockin wrote:

> This patch was developed here to resolve a number of eepro100 issues we
> were seeing. I'd like to get people to try this on their eepro100 chips and
> beat on it for a while.
> 
> volunteers?
> 
> Tim


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


