Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVADUe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVADUe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVADUce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:32:34 -0500
Received: from [209.195.52.120] ([209.195.52.120]:29655 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262155AbVADUaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:30:12 -0500
Date: Tue, 4 Jan 2005 12:18:26 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Adrian Bunk <bunk@stusta.de>
cc: Arjan van de Ven <arjan@infradead.org>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <20050104174712.GI3097@stusta.de>
Message-ID: <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
 <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl>
 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
 <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org>
 <20050104174712.GI3097@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've been useing kernel.org kernels since the 2.0 days and even 
within a stable series I always do a full set of tests before upgrading. 
every single stable series has had 'paper bag' releases, and every single 
one has had fixes to drivers that have ended up breaking those drivers.

the only way to know if a new kernel will work on your hardware is to try 
it. It doesn't matter if the upgrade is from 2.4.24 to 2.4.25 or 2.6.9 to 
2.6.10 or even 2.4.24 to 2.6.10

anyone who assumes that just becouse the kernel is in the stable series 
they can blindly upgrade their production systems is just dreaming.

David Lang

  On Tue, 4 Jan 2005, Adrian Bunk wrote:

> Date: Tue, 4 Jan 2005 18:47:13 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: Arjan van de Ven <arjan@infradead.org>
> Cc: Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
>     William Lee Irwin III <wli@holomorphy.com>,
>     Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
> Subject: Re: starting with 2.7
> 
> On Mon, Jan 03, 2005 at 04:59:02PM +0100, Arjan van de Ven wrote:
>> On Mon, 2005-01-03 at 16:34 +0100, Adrian Bunk wrote:
>>> On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
>>>> On Sun, 2 Jan 2005, Andries Brouwer wrote:
>>>>
>>>>> You change some stuff. The bad mistakes are discovered very soon.
>>>>> Some subtler things or some things that occur only in special
>>>>> configurations or under special conditions or just with
>>>>> very low probability may not be noticed until much later.
>>>>
>>>> Some of these subtle bugs are only discovered a year
>>>> after the distribution with some particular kernel has
>>>> been deployed - at which point the kernel has moved on
>>>> so far that the fix the distro does might no longer
>>>> apply (even in concept) to the upstream kernel...
>>>>
>>>> This is especially true when you are talking about really
>>>> big database servers and bugs that take weeks or months
>>>> to trigger.
>>>
>>> If at this time 2.8 was already released, the 2.8 kernel available at
>>> this time will be roughly what 2.6 would have been under the current
>>> development model, and 2.6 will be a rock stable kernel.
>>
>> as long as more things get fixed than new bugs introduced (and that
>> still seems to be the case) things only improve in 2.6.
>> ...
>
> My main point is not the number of bugs, but the number of regressions.
>
> If you do install a new machine or do a major upgrade (e.g. 2.4 -> 2.6)
> you do some testing whether everything works as expected and if
> something doesn't work, you try to get it working or work around the
> problem.
>
> Inside a stable kernel series (e.g. 2.6.x -> 2.6.y) you hope that an
> upgrade doesn't contain regressions and goes smoothly.
>
> Even the introduction of CONFIG_BLK_DEV_UB in 2.6.9 [1] has bitten
> several people I know.
>
> cu
> Adrian
>
> [1] this is not technically a bug, but e.g. similar common problems
>    for users in the input code were already fixed during 2.5 long
>    before 2.6.0
>
> --
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
