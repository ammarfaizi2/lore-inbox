Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbSJGUCe>; Mon, 7 Oct 2002 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262629AbSJGUCA>; Mon, 7 Oct 2002 16:02:00 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:21682 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262699AbSJGUA4>;
	Mon, 7 Oct 2002 16:00:56 -0400
Message-ID: <3DA1E923.7050707@candelatech.com>
Date: Mon, 07 Oct 2002 13:05:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: george anzinger <george@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Mark Mielke <mark@mark.mielke.cc>, "David S. Miller" <davem@redhat.com>,
       simon@baydel.com, alan@lxorguk.ukuu.org.uk,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
References: <Pine.LNX.4.44.0210071307420.913-100000@xanadu.home> <3DA1D87E.81A1351C@mvista.com> <20021007201111.C5381@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> Now imagine the case when you have 100 different machine types, all
> different, using this device where each hardware designer has decided to
> connect the chip up differently.
> 
> Is putting this crud into drivers going to be maintainable?  No.

I'm not sure which is worse:  A driver that is hard to maintain, or
one that is completely broken on some architectures, even though
numerous people keep re-inventing the fix.

Personally, I'd rather have a hacked up driver that works, but I'm
sure others have other opinions!

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


