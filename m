Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292817AbSBVGpz>; Fri, 22 Feb 2002 01:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292818AbSBVGpf>; Fri, 22 Feb 2002 01:45:35 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:43667 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S292817AbSBVGp2>;
	Fri, 22 Feb 2002 01:45:28 -0500
Message-ID: <3C75E905.9000809@candelatech.com>
Date: Thu, 21 Feb 2002 23:45:25 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dank@kegel.com, linux-kernel@vger.kernel.org, zab@zabbo.net
Subject: Re: is CONFIG_PACKET_MMAP always a win?
In-Reply-To: <3C75A418.2C848B3F@kegel.com> <20020221.215925.41634293.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>    From: Dan Kegel <dank@kegel.com>
>    Date: Thu, 21 Feb 2002 17:51:20 -0800
> 
>    What's the best way to retrieve raw packets from the kernel?
>    
>    a) use libpcap
>  ...   
>    b) use af_packet
>  ...   
>    c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING
>    
>    If I understand it right, b costs one memcpy and one recv, and c costs
>    two memcpys.  Which one wins?
> 
> "a" should be doing "c" when it is available in the kernel.
> If not, get a newer copy of the libpcap sources, preferably
> from Alexey's site:
> 
> ftp.inr.ac.ru:/ip-routing/


And if you can figure out how to do c, and feel like
sharing, please do let me know!  Documentation is a
bit sparse..at least wherever I've been looking.

Enjoy,
Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


