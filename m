Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJDFBA>; Fri, 4 Oct 2002 01:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSJDFBA>; Fri, 4 Oct 2002 01:01:00 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:2539 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S261492AbSJDFA7>;
	Fri, 4 Oct 2002 01:00:59 -0400
Message-ID: <3D9D21D6.4090306@candelatech.com>
Date: Thu, 03 Oct 2002 22:06:30 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 and Netgear GA302T  x 2 locks machine
References: <3D9D16D9.7040008@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Got my two new Netgear GA302t nics today.  They seem to use the
> tg3 driver....

Changed the PCI slot of eth2 to a 32-bit slot, and now it works better...

It passed packets for about 20 seconds, then spit out a bunch of these:

tg3: eth3: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth3: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled
tg3: eth2: Error, poll already scheduled

... Then the machine locked hard


Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


