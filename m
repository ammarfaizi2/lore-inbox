Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281747AbRKULum>; Wed, 21 Nov 2001 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281746AbRKULuc>; Wed, 21 Nov 2001 06:50:32 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:42157 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281743AbRKULuV>;
	Wed, 21 Nov 2001 06:50:21 -0500
Message-ID: <3BFB94D4.10201@stesmi.com>
Date: Wed, 21 Nov 2001 12:49:40 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <Pine.GSO.4.33.0111210945590.795-100000@gurney> <E166VOz-0004kH-00@the-village.bc.nu> <20011121122034.B9978@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Wed, Nov 21 2001, Alan Cox wrote:
> 
>>>CPU0 is labelled as an "AMD Athlon(tm) MP Processor 1800+", as expected.
>>>CPU1 is instead labelled just "AMD Athlon(tm) Processor".
>>>
>>Those strings are read directly out of the CPU. Mine for example says
>>
>>cpu family      : 6
>>model           : 1
>>model name      : AMD-K7(tm) Processor
>>stepping        : 1
>>
> 
> No there is a bug there, I can confirm that mine does the same (ie
> second athlon is not reported with correct model name)

Have you actually verified it by switching the cpu's around? That should 
be the first to do.

// Stefan


