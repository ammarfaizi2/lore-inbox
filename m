Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTKFMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 07:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTKFMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 07:40:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:54507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263528AbTKFMk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 07:40:56 -0500
X-Authenticated: #4512188
Message-ID: <3FAA41C3.9060601@gmx.de>
Date: Thu, 06 Nov 2003 13:42:43 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de>
In-Reply-To: <20031106091746.GA1379@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>>sy id wa
>> 2  0      0 579472  13976 308572    0    0   425    85 1255   645  5 
>>3 84  9
>> 2  0      0 579456  13976 308572    0    0     0     0  725   521  5 
>>5 91  0
>> 1  0      0 579448  13976 308572    0    0     0     0  736   523  2 
>>5 94  0
>> 0  0      0 579448  13976 308572    0    0     0    25  745   439  2 
> 
> 
> [snip]
> 
> This looks good, from a system utilization point of view. I'm wondering
> whether you have the iso image cached? There's no block io going on.
> 
> It does like more like a CPU scheduler problem at this point.


Ok, then it is Nick's turn, I guess. :-) Yeah most probably the iso is 
cached, as it was not the first time I burnt the iso when I did the 
vmstat, furthermore I have 1 GB of RAM... The other thing which doesn't 
speack for i/o problems, I guess: Just the first seconds when I start 
erasing the CD-RW the mouse hangs and heavily stutters, then it is OK 
until actual burning of image begins, then the mouse slightly stutters. 
All this was not with test9-mm1.


