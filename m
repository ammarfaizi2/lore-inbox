Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUIVUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUIVUXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUIVUXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:23:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:26814 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267180AbUIVUTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:19:08 -0400
Message-ID: <4151DDFF.6000902@us.ibm.com>
Date: Wed, 22 Sep 2004 13:18:07 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Leonid Grossman <leonid.grossman@s2io.com>
CC: "'Andi Kleen'" <ak@suse.de>, "'David S. Miller'" <davem@davemloft.net>,
       "'John Heffner'" <jheffner@psc.edu>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
References: <200409162034.i8GKYq39023185@guinness.s2io.com>
In-Reply-To: <200409162034.i8GKYq39023185@guinness.s2io.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leonid Grossman wrote:

>>From: Nivedita Singhvi [mailto:niv@us.ibm.com] 
>>Sent: Thursday, September 16, 2004 9:19 AM
>>To: Leonid Grossman
>>Cc: 'Andi Kleen'; 'David S. Miller'; 'John Heffner'; 
>>netdev@oss.sgi.com
>>Subject: Re: The ultimate TOE design
>>
>>Leonid Grossman wrote:
>>
>>
>>>We can dream about benefits of huge MTUs, but the reality is that 
>>>moving beyond 9k MTU is years away. Reasons - mainly infrastructure, 
>>>plus MTU above ~10k may loose checksum protection (granted, this 
>>>depends whether the errors are simple or complex, and also this may 
>>>not be a showstopper for some people).
>>>Even 9k MTU is very far from being universally accepted, 
>>>eight years after our Alteon spec went out :-).
>>
>>One other factor is TCP congestion control, and congestion 
>>windows we obey. Most of the time, you just can't send that much.
> 
> 
> It's a bit painful to setup, but in general with 9k jumbos and TSO we were
> able to get close to pci-x 133 limit - both in LAN and WAN tests.
> Leonid

Cool, but a very specific environment, no? ;)

What concerns me about all this is that it seems
so very host-centric design. Wouldn't it be nice if
we had a little bit more network-centric worldview
when designing network infrastructure?

It isn't just a matter of how had we can push stuff
out, it also matters how much the network can take.
Blasting tens of gigs into the ether seems all very
exciting sexy and cool, but suited for dedicated links
or network attached storage channels, not general-purpose
networking on the Internet or intra-nets.

And if that is the case, we're talking about a much
smaller market (but perhaps a more profitable
one ;))...

thanks,
Nivedita



