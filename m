Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWFIBoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWFIBoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFIBoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:44:07 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:16799 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751102AbWFIBoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:44:06 -0400
Message-ID: <4488D25D.4010105@cmu.edu>
Date: Thu, 08 Jun 2006 21:43:57 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060529)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: what processor family does intel core duo L2400 belong to?
References: <4488B159.2070806@cmu.edu>	 <986ed62e0606081650k227c948dy2c675bedd7a254fa@mail.gmail.com>	 <4488C098.90802@cmu.edu> <986ed62e0606081750w1be36f9fn35d69bffbc27f294@mail.gmail.com>
In-Reply-To: <986ed62e0606081750w1be36f9fn35d69bffbc27f294@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more thing:
http://prisguide.hardware.no/product.php?product_id=39908&view=productinfo

It turns out the socket is "Socket 479M" ... thats pentium-m isn't it?

This also seems to agree its pentium-m:
http://www.answers.com/topic/intel-processor-confusion

By the way, these results came from a google of "L2400 prescott", so its 
not like my google is swaying this one way or another

Therefore, i'm going with pentium-m!

Thanks for the help guys,
George


Barry K. Nathan wrote:
> On 6/8/06, George Nychis <gnychis@cmu.edu> wrote:
> 
>> Put me in your shoes, what would you test to see which one is the true
>> choice?
> 
> 
> I'd start by seeing which one (if either) will boot the system (with
> CONFIG_X86_GENERIC disabled). In the past, when I've had trouble
> deciding, this has actually eliminated more possibilities than you
> might expect.
> 
> Beyond that, I don't know for certain what I would test with. Perhaps
> I'd start with lmbench, or if I was using the system for 3D stuff,
> perhaps framerates from glxgears or a 3D game. If I was using the
> system for network stuff, I'd run network benchmarks. (Perhaps disk
> benchmarks would be good too, but my experience is that network
> performance tends to suffer first and/or more severely, especially if
> Gigabit Ethernet or slow CPU's are involved.)
> 
> If both choices boot, the performance difference may be quite small.
