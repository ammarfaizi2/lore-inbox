Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTKFNLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTKFNLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:11:33 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:22149 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263570AbTKFNLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:11:32 -0500
Message-ID: <3FAA4880.8090600@cyberone.com.au>
Date: Fri, 07 Nov 2003 00:11:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de> <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de>
In-Reply-To: <20031106130553.GD1145@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Fri, Nov 07 2003, Nick Piggin wrote:
>
>>
>>Jens Axboe wrote:
>>
>>
>>>sys time is usually pretty high if that is the case, and it's hovering
>>>around 5% here... Prakash, are you sure that dma is enabled on the
>>>drive? When you see the problem, do a vmstat 1 for 10 seconds so you are
>>>absolutely sure you are sending the info from when the problem occurs.
>>>
>>>
>>Although have a look at the interrupts field in vmstat 1255, 725, 736 ...
>>
>
>Yeah that is pretty high for just doing a burn, maybe something else is
>

;) you are forgetting 2.6 should give 1000 timer interrupts per second!

