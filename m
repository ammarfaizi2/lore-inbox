Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVAJNDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVAJNDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVAJNDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:03:42 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60814 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262230AbVAJNDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:03:40 -0500
Message-ID: <41E27D29.2040001@grupopie.com>
Date: Mon, 10 Jan 2005 13:03:37 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: "Patrick J. LoPresti" <patl@curl.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random vs. /dev/urandom
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com> <s5gzmzjbza1.fsf@egghead.curl.com> <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> [...]
> One is free to use any number of samples. The short number of samples
> was DELIBERATELY used to exacerbate the problem although a number
> or nay-sayers jumped on this in an attempt to prove that I don't
> know what I'm talking about.

It seems to me that you actually don't.

Since this is a *uniform* distribution in the range [0..2^N[, than any 
of those N bits must also show a uniform distribution, or the 
distribution of the sum of the bits wouldn't be uniform. (isn't this 
obvious?)

It would be different of course, if this was not a uniform distribution, 
or the range was not a power of 2...

Of course, I agree that throwing away 5 bits in every byte of perfect 
entropy that the kernel worked so hard to gather is just wrong, but the 
randomness of the result is not the reason why.

> In the first place, the problem was to display the error of using
> an ANDing operation to truncate a random number. In the limit,
> one could AND with 0 and show that all randomness has been removed.

Not really.. you just get a perfect random uniform distribution if the 
range [0..0] :)

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

