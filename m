Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSC2WUv>; Fri, 29 Mar 2002 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312248AbSC2WUm>; Fri, 29 Mar 2002 17:20:42 -0500
Received: from dns2.s.bonet.se ([212.181.54.3]:41488 "EHLO dns2.s.bonet.se")
	by vger.kernel.org with ESMTP id <S312235AbSC2WUg>;
	Fri, 29 Mar 2002 17:20:36 -0500
Message-ID: <3CA4E82D.6010408@2gen.com>
Date: Fri, 29 Mar 2002 23:18:21 +0100
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9+) Gecko/20020311
X-Accept-Language: en,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.17 with VT8367 [KT266] crashes on heavy ide load togeter
 with heavy network load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, I'd like to thank Andre Hedrick for the link to:
http://www.tecchannel.de/hardware/817/index.html

It was very helpful in making me understand why the performance of my 
newly bought Adaptec 2400A IDE-Raid card sucked so badly in combination 
with my VIA KT133 based board.

I have done some testing (on the Win platform since that's where the 
patches to remedy this situation are available) that shows quite nicely 
how the PCI bus gets totally overrun by transfer rates in excess of 
approximately 74MB/s and instead slows down.

Short summary
=============
Expected rate		Experienced rate
84MB/s 
		50MB/s
80MB/s 
		64MB/s
74MB/s 
		74MB/s

(If someone is very interested, mail me and I can publish some transfer 
rate graphs online)

I just have a few questions:

1) Is there any efforts made to add the "hacks" that VIA has put into 
their (win only patch) at:
http://www.viaarena.com/?PageID=66#raid
into the kernel? Does VIA give out specs what the patch does?

2) Has anyone had any experiences with the VIA KT333 chipset? Does it 
have the same numerous problems that the KT133/266 seem to have?

3) Could someone recommend another non-VIA chipset to use instead that 
they've had good experiences with? (since I am going to buy a new 
motherboard to remedy this situation)

Thanks in advance and please CC me any answers since I'm not on the list.

Regards,
David
david@2gen.com

