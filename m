Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbTA3TG3>; Thu, 30 Jan 2003 14:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbTA3TG3>; Thu, 30 Jan 2003 14:06:29 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:53469 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267605AbTA3TG3>;
	Thu, 30 Jan 2003 14:06:29 -0500
Message-ID: <3E3979E7.2080908@candelatech.com>
Date: Thu, 30 Jan 2003 11:15:51 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Rozhavsky <mrozhavsky@mrv.com>
CC: vlan@scry.wanfear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8021q memory leak
References: <20030130182936.GC3348@mike.nbase.co.il>
In-Reply-To: <20030130182936.GC3348@mike.nbase.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rozhavsky wrote:
> Hi,
> 
> There is a memory leak in vlan module of 2.4.20
> 
> When last vlan of the group is removed the group is unhashed but not
> deleted.
> 
> Attached patch fixes this memory leak and completes implementation of
> memory debug output.

I believe some of the memory leaks were fixed in the -pre3 patch.
I'll wander through the code to make sure that the ones you found
were addressed.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


