Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUCKSRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbUCKSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:16:49 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:25986 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S261629AbUCKSPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:15:54 -0500
Message-ID: <4050AE17.8040600@brad-x.com>
Date: Thu, 11 Mar 2004 13:21:11 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yury V. Umanets" <umka@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com>	 <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>	 <40503120.9000008@brad-x.com>  <20040311020832.1aa25177.akpm@osdl.org>	 <1079013947.24999.17.camel@firefly>  <4050A047.9030603@brad-x.com> <1079028562.31103.1.camel@firefly>
In-Reply-To: <1079028562.31103.1.camel@firefly>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yury V. Umanets wrote:
> On Thu, 2004-03-11 at 19:22, Brad Laue wrote:
> 
>>Yury V. Umanets wrote:
>>
>>>Hello,
>>>
>>>I have impression, that it is somehow related to ACPI and CPU
>>>temperature. When CPU gets more hot ksoftirqd starts to eat 99% of CPU.
>>>
>>>It may be checked by disabling ACPI (if enabled) and/or monitoring
>>>/proc/acpi/thermal_zone/THRM/temperature (if any).
>>
>>Happens on a system without ACPI or Power Management of any kind enabled 
>>though.
>>
>>Brad
> 
> Then have you seen clear dependence of ksoftirqd getting crazy on system
> load? Or something else?

Not sure what you mean; when the problem begins to get bad, anything 
that tries to use a network interface causes ksoftirqd to jump to 99% 
CPU, and eventually it just stays there at idle. The process trying to 
use the network uses abnormal amounts of CPU time as well.

Brad
