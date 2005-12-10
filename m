Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVLJNmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVLJNmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 08:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVLJNmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 08:42:08 -0500
Received: from mail.tmr.com ([64.65.253.246]:4052 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932347AbVLJNmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 08:42:07 -0500
Message-ID: <439ADAF3.9040705@tmr.com>
Date: Sat, 10 Dec 2005 08:41:07 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <200512051158.06882.rob@landley.net> <4395DDA8.8000003@tmr.com> <200512071214.26574.rob@landley.net>
In-Reply-To: <200512071214.26574.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>
>I'm under the impression the problem with cryptoloop is bad cryptography:
>http://lwn.net/Articles/67216/
>
>Anybody actually using cryptography with an expoitable weakness needs all the 
>wake-up calls they can get.  This is _not_ a case where you want to support 
>old broken crap, that defeats the whole purpose of using cryptography in the 
>first place.
>
>Especially the cryptoloop removal was an intentional decision that the kernel 
>developers made.  People raised their objections at the time, and these were 
>taken into consideration when making the decision:
>http://kerneltrap.org/node/2433
>
>Re-raising the same objections over and over again when they've already been 
>aired, considered, and rejections is called "whining".
>
Repeating the same information over and over until it sinks in is called 
"rote learning." The question is not if cryptoloop is perfect, every 
crypto seems to fail eventually, recently md5 was cracked, etc. But 
people have used cryptoloop now, and removing it from the kernel will 
lock them out of their own data, or prevent them from moving forward. 
There's no replacement for cryptoloop, so I can't just reconfigure X and 
still read my 147 DVDs full of business data, or access the current data 
on 34 laptops around the country.

In most cases CL is not expected to protect against goverment agencies 
but rather stolen laptops in airports (yes the pros have added MacOS and 
Linux to their business model) or the occasional lost DVD in the mail. 
Removing CL is not a hell of a lot better morally than these viruses 
which encrypt your data and then hold it for ransom, with the price 
being doing without security fixes in future kernels.

Given that CL has minimal (essentially no) maintenence cost, I wish the 
ivory tower developers could understand that real people have invested 
real money in it, and real data in the technology. Since there is no 
alternative solution offered, CL is far better than no crypto at all, 
and I wish there were a few more developers who had experience working 
in the real word.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

