Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVGHUkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVGHUkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVGHUi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:38:57 -0400
Received: from relay03.pair.com ([209.68.5.17]:32787 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262851AbVGHUfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:35:39 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42CEE39B.3050803@cybsft.com>
Date: Fri, 08 Jul 2005 15:35:39 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mr.fred.smoothie@pobox.com
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
References: <42CEC7B0.7000108@cybsft.com> <20050708191326.GA6503@elte.hu> <161717d505070812385dea6099@mail.gmail.com>
In-Reply-To: <161717d505070812385dea6099@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Neuer wrote:
> On 7/8/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
>>* K.R. Foley <kr@cybsft.com> wrote:
>>
>>
>>>Ingo,
>>>
>>>I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when
>>>running the RT patches.
> 
> 
> <snip>
> 
>>>2.6.12 doesn't seem to have the
>>>problem at all, only when running the RT patches. It SEEMS to have
>>>gotten worse lately.
> 
> 
> <snip>
> 
>>>Adjusting the delay in the keyboard repeat seems to help. Any ideas?
>>
>>hm. Would be nice to somehow find a condition that triggers it.
> 
> 
> FWIW, I've had this problem from time to time on my Compaq Presario
> x1010us laptop (which also uses the ICH-4 chipset) with several kernel
> versions between 2.6.7 and 2.6.12, and I have _not_ been running the
> RT patches (though I plan to start soon).
> 
> It seems to only happen when the laptop has been running for a while.
> Also, X has been running each time. When it occurs, the stuck key
> events follow the mouse focus from window to window, and in the few
> cases where I'm able to either switch out of X to a different VT or
> kill X, the keyboard is still "wedged" -- if I recall correctly,
> switching VTs results in no keyboard events reaching that VT (as if X
> is still consuming them). Can't remember what happens when I've
> successfully killed X.

I have seen this happen once or twice, but this behaves more like the 
keyboard really is stuck. The situation I am having is very brief 
repeats of a key rather than just sticking forever. FWIW, when I have 
seen the above situation it behaved just as you described with the stuck 
key following the focus.

> 
> Again, happens uncommonly enough that I haven't put much effort into
> debugging it.
> 
> Anyway, unless it's a similar but unlrelated bug, it's not _caused_ by RT.
> 
> Dave
> 


-- 
    kr
