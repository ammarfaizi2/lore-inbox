Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCVWwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUCVWwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:52:21 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:55543 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261158AbUCVWwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:52:19 -0500
Message-ID: <405F6DF8.4060307@matchmail.com>
Date: Mon, 22 Mar 2004 14:51:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313175712.GY14833@fs.tum.de> <20040313235940.GQ20174@waste.org> <20040314003220.GG14833@fs.tum.de> <20040314005726.GS20174@waste.org>
In-Reply-To: <20040314005726.GS20174@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sun, Mar 14, 2004 at 01:32:20AM +0100, Adrian Bunk wrote:
> 
>>On Sat, Mar 13, 2004 at 05:59:40PM -0600, Matt Mackall wrote:
>>
>>>On Sat, Mar 13, 2004 at 06:57:13PM +0100, Adrian Bunk wrote:
>>>...
>>>
>>>>>But I think it's fair to say that new features that are on by default
>>>>>are in fact bloat in some sense.
>>>>
>>>>Perhaps in some sense, but not in any interesting sense.
>>>>
>>>>For the average computer you can buy at your supermarket today it isn't 
>>>>very interesting whether the kernel is bigger by 1 MB or not.
>>>>
>>>>People who need to care about the size of the kernel [1] use hand-tuned 
>>>>.config's that are far away from defconfig - and those people wouldn't 
>>>>enable unneeded features that are on by default.
>>>
>>>And my coverage of creep in other _commonly used_ parts of the kernel
>>>would then be nil. Given that allyesconfig can't be expected to build
>>>a kernel on any given day, defconfig is the least arbitrary and most
>>>useful of arbitrary choices.
>>>
>>>
>>>>You use a metric "size increase of a defconfig kernel [2]", and I simply 
>>>>claim that this metric doesn't measure anything useful for practical 
>>>>purposes.
>>>
>>>defconfig is not an unreasonable approximation of features people use. 
>>
>>What exactly is your goal?
>>
>>As already said:
>>  *** For the average user, the size of the kernel doesn't matter *** [1]
>>  *** People that care about size don't use defconfig ***
> 
> 
> Neither of these things matter. The important thing is that defconfig
> encompasses a range of common options that are likely to be used, thus
> people care about growth in those areas regardless of what subset or
> superset they actually use. It is not possible to see growth in the
> code for option FOO if option FOO is not enabled. As I pointed out in
> the last message, allyesconfig would be ideal for my purposes and
> fails both of the above quite dramatically.

With CONFIG_BROKEN, in the kernel for a while, why doesn't allyesconfig 
work on a stock kernel?  Maybe there are some logic errors in kconfig...
