Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbUCTJ3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbUCTJ3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:29:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:9424 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263264AbUCTJ3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:29:18 -0500
X-Authenticated: #4512188
Message-ID: <405C0EF1.1060104@gmx.de>
Date: Sat, 20 Mar 2004 10:29:21 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Thomas Schlichter <thomas.schlichter@web.de>, ross@datscreative.com.au,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
References: <200403181019.02636.ross@datscreative.com.au>	 <200403191955.38059.thomas.schlichter@web.de>  <405B4893.70701@gmx.de> <1079738422.7279.308.camel@dhcppc4>
In-Reply-To: <1079738422.7279.308.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:
> 
> 
>>Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
>>active state:            C1
>>default state:           C1
>>bus master activity:     00000000
>>states:
>>    *C1:                  promotion[--] demotion[--] latency[000] 
>>usage[00000000]
>>     C2:                  <not supported>
>>     C3:                  <not supported>
>>
>>I am currently NOT using APIC mode (nforce2, as well) and using vanilla 
>>2.6.4. It seems C1 halt state isn't used, which exlains why I am having 
[snip]
> 
> 
> Actually I think it is that we don't _count_ C1 usage.

Hmm, OK, then I am really puzzled what specifically about mm sources 
make my idle temps hotter, as I still couldn't properly resolve it what 
is causing it. I thought ACPI, but no, using APM only does the same (apm 
only with vanilla is low temp though.)

Prakash
