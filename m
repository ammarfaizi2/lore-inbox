Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262069AbSJEF6E>; Sat, 5 Oct 2002 01:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262071AbSJEF6E>; Sat, 5 Oct 2002 01:58:04 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:46736 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262069AbSJEF6D>;
	Sat, 5 Oct 2002 01:58:03 -0400
Message-ID: <3D9E80A7.1010403@candelatech.com>
Date: Fri, 04 Oct 2002 23:03:19 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
References: <20021004.142428.101875902.davem@redhat.com>	<Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au> <20021004.181537.104336257.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: James Morris <jmorris@intercode.com.au>
>    Date: Sat, 5 Oct 2002 11:20:06 +1000 (EST)
> 
>    On Fri, 4 Oct 2002, David S. Miller wrote:
>    
>    > You reported the other week problems with two Acenic's in
>    > this same machine right?  The second Acenic wouldn't even probe
>    > properly.  And the two Acenic's were identical.
>    
>    FWIW, my GA302T seems fine with the kernel he originally reported 
>    (2.4.20-pre8).
> 
> Yes but are you running parallel pktgen streams on two
> tg3's? :-)

Heh, tis true, I'm abusing them horribly. ;)

So far, the tulip driver and DFE-570tx & Phobos NICs are the only
thing I've found that can stand up to my tests...  (e1000 pukes,
old acenic pukes (after quite a while), tg3 pukes, at least currently...

I'll try this this weekend.  Thanks for the suggestion.

Ben

> 
> Ben, by chance, does reverting the patch below cure your problems?

[patch snipped]


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


