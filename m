Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314260AbSDVQVT>; Mon, 22 Apr 2002 12:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSDVQVS>; Mon, 22 Apr 2002 12:21:18 -0400
Received: from ip68-3-16-134.ph.ph.cox.net ([68.3.16.134]:62425 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S314260AbSDVQVS>;
	Mon, 22 Apr 2002 12:21:18 -0400
Message-ID: <3CC43875.6010002@candelatech.com>
Date: Mon, 22 Apr 2002 09:21:09 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: DJ Barrow <dj.barrow@asitatech.com>
CC: root@chaos.analogic.com,
        "Brian O'Sullivan" <brian.osullivan@asitatech.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
In-Reply-To: <Pine.LNX.3.95.1020422113750.11343A-100000@chaos.analogic.com> <20020422160154Z314241-22651+13871@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



DJ Barrow wrote:

> Richard,
> I agree The least offensive way would be to pass in a sring from the caller,
> I didn't spot the second endian bug till you mentioned it ;-).


The input should always be in network-byte-order, so there is no
endian problem, at least.  The other problem can be worked around
by the caller, though a second, similar, method that took an pre-allocated
buffer would definately be nice.

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


