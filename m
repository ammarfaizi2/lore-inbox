Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbUCTKZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbUCTKZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:25:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:39562 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263332AbUCTKZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:25:22 -0500
X-Authenticated: #4512188
Message-ID: <405C1C0D.9050108@gmx.de>
Date: Sat, 20 Mar 2004 11:25:17 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: Len Brown <len.brown@intel.com>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
References: <200403181019.02636.ross@datscreative.com.au> <1079738422.7279.308.camel@dhcppc4> <405C0EF1.1060104@gmx.de> <200403202019.44612.ross@datscreative.com.au>
In-Reply-To: <200403202019.44612.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> On Saturday 20 March 2004 19:29, Prakash K. Cheemplavam wrote:
> 
>>Len Brown wrote:
>>
>>>On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:
>>>
>>>
>>>
>>>>Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
>>>>active state:            C1
>>>>default state:           C1
>>>>bus master activity:     00000000
>>>>states:
>>>>   *C1:                  promotion[--] demotion[--] latency[000] 
>>>>usage[00000000]
>>>>    C2:                  <not supported>
>>>>    C3:                  <not supported>
>>>>
>>>>I am currently NOT using APIC mode (nforce2, as well) and using vanilla 
>>>>2.6.4. It seems C1 halt state isn't used, which exlains why I am having 
>>
>>[snip]
>>
>>>
>>>Actually I think it is that we don't _count_ C1 usage.
>>
>>Hmm, OK, then I am really puzzled what specifically about mm sources 
>>make my idle temps hotter, as I still couldn't properly resolve it what 
>>is causing it. I thought ACPI, but no, using APM only does the same (apm 
>>only with vanilla is low temp though.)
> 
> 
> Have you seen this thread, it may be relevant?
> Re: [2.6.4-rc2] bogus semicolon behind if()
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4170.html

Hi Ross, I don't think so, as I currently don't use APIC and thus fix in 
above post wouldn't help me. Or should I read further?

cya,

Prakash

