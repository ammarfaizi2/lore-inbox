Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDDG01>; Thu, 4 Apr 2002 01:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSDDG0S>; Thu, 4 Apr 2002 01:26:18 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:49085 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S310979AbSDDG0E>;
	Thu, 4 Apr 2002 01:26:04 -0500
Message-ID: <3CABF1FC.1070201@candelatech.com>
Date: Wed, 03 Apr 2002 23:26:04 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel hangs on boot when no keyboard, mouse are plugged in.
In-Reply-To: <3CABBC31.8060608@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For posterity's sake, compiling without APM seems to
make the problem go away...  Fortunately, I don't need
APM too badly...

Ben

Ben Greear wrote:

> I have reproduced this with several different kernels, including
> a standard RedHat 2.4.9-13 kernel.
> 
> The problem is that the kernel will hang when booting without
> a keyboard or mouse plugged in.
> 
> It hangs right after the line:
> apm:  BIOS version 1.2 Flags 0x03 (Driver version 1.16)
> 
> When the kernel boots (with kbd plugged in), the next line
> will be about starting swap.
> 
> I'm compiling a kernel now without APM support in the hope
> that that will make the problem go away.  Any other suggestions
> are welcome!
> 
> Thanks,
> Ben
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


