Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUGXMQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUGXMQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 08:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268545AbUGXMQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 08:16:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:43982 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268544AbUGXMQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 08:16:18 -0400
X-Authenticated: #21910825
Message-ID: <4102530C.8060604@gmx.net>
Date: Sat, 24 Jul 2004 14:16:12 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [FC1], 2.6.8-rc2 kernel, new motherboard problems
References: <Pine.LNX.4.44.0407211334260.3000-100000@mail.birdvet.org> <200407240158.56434.gene.heskett@verizon.net> <1090649207.1006.12.camel@mindpipe> <200407240520.31906.gene.heskett@verizon.net>
In-Reply-To: <200407240520.31906.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett schrieb:

> On Saturday 24 July 2004 02:06, Lee Revell wrote:
> 
>>On Sat, 2004-07-24 at 01:58, Gene Heskett wrote:
>>
>>>On Friday 23 July 2004 20:55, Lee Revell wrote:
>>>
>>>>On Thu, 2004-07-22 at 14:49, Nuno Monteiro wrote:
>>>>
>>>>>On 2004.07.22 13:49, Gene Heskett wrote:
>>>>>
>>>>>>00:04.0 Ethernet controller: nVidia Corporation nForce2
>>>>>>Ethernet Controller (rev a1)
>>>>>>        Subsystem: Biostar Microtech Int'l Corp: Unknown
>>>>>>device 2301
>>>>>>
>>>>>>However, this, nor the xconfig helps, still don't indicate
>>>>>>which driver I should be using, or where to get it if its not
>>>>>>in the kernel's tree yet a/o 2.6.8-rc2.  So thats the next
>>>>>>piece of data I need.
>>>>>
>>>>>Hi Gene,
>>>>>
>>>>>
>>>>>I believe you'll need forcedeth.c for this one. It's called
>>>>>"Reverse Engineered nForce Ethernet support", under Device
>>>>>Driver -> Networking -> Ethernet 10/100 Mbit.

Right. And it should work perfectly with that driver. However, I recommend
to use at least 2.6.8-rc2 because it has some bugfixes you may need.


>>>>Wow, nVidia won't release the specs for a *10/100 ethernet
>>>>controller*? Having to reverse engineer a network driver is
>>>>ridiculous in this day and age.  I can understand binary-only
>>>>graphics drivers, there is a lot of valuable IP in there, but
>>>>this is a freaking network card.  What do they expect people to
>>>>do?
>>>>
>>>>Maybe some bad press would set them straight.
>>>>
>>>>Lee

Could you please check the facts (or ask the driver authors) before
suggesting to haunt NVidia with bad press? Thanks.


>>>Nvidia is immune to bad press, and probably cannot release a thing
>>>other than some API help due to copyright contracts with the
>>>coders who wrote their winderz drivers for them,  The only cure
>>>would be for them to hired a couple of dozen programmers of the
>>>minimum quality the open source programmers exhibit, which I
>>>happen to think is top notch, and the CEO can only see outgo
>>>without compensatory income for all that salary, so they contract
>>>it out for a known cost, and get tied up in restrictive contracts.
>>
>>I am not talking about them releasing driver code, I am just talking
>>about datasheets so we can write our own driver, something that
>>tells you which bits to write to which registers to get it to do
>>$FOO.
>>
>>Their net cost: $0.
>>
>>Lee
> 
> 
> I'm under the impression the forcedeth writers did have access to this 
> data.  Is this incorrect? The question is directed at the forcedeth 
> authors.  If you are one, then please clarify.

I am one of the authors. We did not have any information in the first
place, but now that our reverse engineered driver works well, NVidia
contributed bugfixes and gigabit support to our driver.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
