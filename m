Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281456AbRKRVmS>; Sun, 18 Nov 2001 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280149AbRKRVmI>; Sun, 18 Nov 2001 16:42:08 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:17796
	"HELO fugmann.dhs.org") by vger.kernel.org with SMTP
	id <S280132AbRKRVlx>; Sun, 18 Nov 2001 16:41:53 -0500
Message-ID: <3BF82B1E.8090305@fugmann.dhs.org>
Date: Sun, 18 Nov 2001 22:41:50 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Jasen <jjasen1@umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111181459340.12354143-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2001 09:11 PM, John Jasen wrote:

> On Sun, 18 Nov 2001, Anders Peter Fugmann wrote:
>>
>>Another thing... Is it the same machine?
>>
> 
> I have three machines with SiS630 boards at the moment.
> 
> Two are identical, except for current kernel. (labrat5 and labrat6)


Hmm. It seems that these machines are in fact not identical.
I would strongly suggest that you try to boot either one with another 
kernel, and see how it reacts.

(if labrat6 is still fast using a 2.4 kernel, or if labrat5 is still 
slow with a 2.2 kernel, you have successfully shown a hardware/BIOS 
differnce between the two machines.)

Another idea could be not to compile in SIS support.
It might be that the driver is broken. The 2.2 kernel does not have 
support for the chipset, and uses general drivers instead. That should 
explain why throughput is higher in 2.4 kernel.

Thats the best I can do for now. Sorry.


> configs and lspci output added to
> http://www.realityfailure.org/~jjasen/SiS630


I really cannot understand why they differ, since Revision numbers are 
identical, but alot of IO-ports are not. Maybe you have two different 
revisions of the same motherboard.
Anyone else care to try and explain?

Regards
Anders Fugmann

