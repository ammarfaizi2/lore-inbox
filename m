Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWGVSK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWGVSK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWGVSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 14:10:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31900 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750935AbWGVSK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 14:10:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44C26991.2080902@s5r6.in-berlin.de>
Date: Sat, 22 Jul 2006 20:08:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153524422.44c162c65c21b@portal.student.luth.se> <44C1BA4A.4070107@s5r6.in-berlin.de> <1153588128.44c25ba03071c@portal.student.luth.se>
In-Reply-To: <1153588128.44c25ba03071c@portal.student.luth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.906) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
> Citerar Stefan Richter <stefanr@s5r6.in-berlin.de>:
...
>>Drivers in 2.4 and 2.6 differ. We don't put 2.4-compatibility code into 
>>2.6. And the bool type won't get into 2.4.
> 
> It doesn't?! Good, that simplify it to only a:
> typedef _Bool bool;
> line. Did googled on it but did not find anything that comfirmed or denied it.
...

Well, it's because the 2.4 mainline receives only bug fixes now. You can 
imagine that since 2.5 was started, new data types were added in 2.5/2.6 
but never backported to 2.4, especially if they were tied to 
infrastructural changes or new features.

Of course there may be downstream projects who maintain 2.4 drivers to 
further extent than the 2.4 mainline. But this doesn't imply a 
requirement to put compatibility code into 2.6.
-- 
Stefan Richter
-=====-=-==- -=== =-==-
http://arcgraph.de/sr/
