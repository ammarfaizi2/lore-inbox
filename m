Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbTKEKgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbTKEKgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:36:00 -0500
Received: from mail.gmx.de ([213.165.64.20]:52956 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262881AbTKEKf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:35:57 -0500
X-Authenticated: #4512188
Message-ID: <3FA8D2B6.5020508@gmx.de>
Date: Wed, 05 Nov 2003 11:36:38 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <3FA8D059.7010204@cyberone.com.au> <20031105102904.GK1477@suse.de>
In-Reply-To: <20031105102904.GK1477@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 05 2003, Nick Piggin wrote:
> 
>>
>>Prakash K. Cheemplavam wrote:
>>
>>
>>>SOmething else I noticed with new 2.6tes9-mm2 kernel: Now the mouse 
>>>stutters slighty when burning (in atapi mode). I am now using as 
>>>sheduler. Shoudl I try deadline or do you this it is something else? 
>>>Should I open a new topic?
>>>
>>
>>This is more likely to be the CPU scheduler or something holding
>>interrupts for too long. Are you running anything at a modified
> 
>                  ^^^^^^^^
> 
> precisely, that's why the actual interface that cdrecord uses is the
> primary key to knowing what the problem is.

As said, I'll report back later...

Prakash

[OT] Something about this kernel list is stupid: It always wants to 
reply to the author instead of the list, generating double the traffic 
if one doesn't pay attention...



