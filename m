Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJEFp2>; Sat, 5 Oct 2002 01:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbSJEFp2>; Sat, 5 Oct 2002 01:45:28 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:38800 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262062AbSJEFp1>;
	Sat, 5 Oct 2002 01:45:27 -0400
Message-ID: <3D9E7DBC.8070708@candelatech.com>
Date: Fri, 04 Oct 2002 22:50:52 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 and Netgear GA302T  x 2 locks machine
References: <Mutt.LNX.4.44.0210050151050.21370-100000@blackbird.intercode.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Thu, 3 Oct 2002, Ben Greear wrote:
> 
> 
>>Changed the PCI slot of eth2 to a 32-bit slot, and now it works
>>better...
>>
>>It passed packets for about 20 seconds, then spit out a bunch of these:
>>
> 
> 
> Which kernel version?  There was a lockup problem for the GA302T just 
> after NAPI went in (which was fixed soon after).

This was 2.4.20-pre8, ie quite recent.  I didn't see any mention of
tg3 in the pre9 patch that just came out.

I'm beginning to think SMP may not be worth it...will try in my trusty
P-IV single-processor cheap-o box next.

Ben

> 
> 
> - James


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


