Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUIPNLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUIPNLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUIPNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:11:19 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:62177 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268039AbUIPNKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:10:52 -0400
Message-ID: <414990C6.6060800@kolivas.org>
Date: Thu, 16 Sep 2004 23:10:30 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.8.1-ck7-web100] Badness in cfq_sort_rr_list
References: <1072359679.20040916142632@dns.toxicfilms.tv> <20040916125824.GD3544@suse.de>
In-Reply-To: <20040916125824.GD3544@suse.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Sep 16 2004, Maciej Soltysiak wrote:
> 
>>Hi,
>>
>>I have just had this:
>>Badness in cfq_sort_rr_list at drivers/block/cfq-iosched.c:428
>>
>>[ more of the trace at http://dns.toxicfilms.tv/cfq.txt ]
>>
>>On a 2.6.8.1 with:
>>- patch-2.6.8.1-ck7.bz2
>>- web100-2.5.0-200408311033.tar.gz
>>
>>I know ck7 uses CFQ as deafult and that web100 touches only tcp stuff.
> 
> 
> You can ignore it, it's harmless. Con has the extra updates to fix this,
> they are also in 2.6.9-rc2-mm1 as posted by Andrew earlier today.

The fix for this one has been up for a while here:

http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ckdev/cfq_v2_20040909.patch

Cheers,
Con
