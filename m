Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVCAUfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVCAUfC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVCAUfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:35:01 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:4493 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262056AbVCAUeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:34:44 -0500
Message-ID: <4224D1DF.30909@candelatech.com>
Date: Tue, 01 Mar 2005 12:34:39 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com> <4224CE98.2060204@candelatech.com> <Pine.LNX.4.61.0503011523330.706@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0503011523330.706@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Tue, 1 Mar 2005, Ben Greear wrote:

> I supplied the actual settings.
> 
>> What happens if you just don't muck with the NIC and let it 
>> auto-negotiate
>> on it's own?
>>
> 
> It goes to half-duplex and runs 9 to 9.5 megabytes/second as stated
> above.
> 
> That's why I think 1/2 duplex is __really__ full-duplex.

half-duplex will run near line speed in one direction.  Try sending in
both directions at the same time and you'll get closer to 40% of the
link utilization...  Also, if you see any collisions you are in half-duplex
mode.

You could try connecting the NICs back-to-back with a cross-over
cable to take your switch out of the loop?

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

