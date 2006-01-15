Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWAORnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWAORnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 12:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWAORnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 12:43:09 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:61899 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932109AbWAORnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 12:43:07 -0500
Message-ID: <43CA89A4.3010000@cfl.rr.com>
Date: Sun, 15 Jan 2006 12:43:00 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH] pktcdvd & udf bugfixes
References: <43C5D71B.1060002@cfl.rr.com> <m3oe2e2983.fsf@telia.com> <43C94464.4040500@cfl.rr.com> <m3hd861o2r.fsf@telia.com> <43C982C0.1070605@cfl.rr.com> <m3r779z9on.fsf@telia.com>
In-Reply-To: <m3r779z9on.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, excellent.  Also, is the memory currently non pagable?  Is there a 
reason for that?

Peter Osterlund wrote:

>Phillip Susi <psusi@cfl.rr.com> writes:
>
>  
>
>>Peter Osterlund wrote:
>>  > OK, so it appears you can make packets bigger than 64KB. Can I please
>>    
>>
>>>have those patches so I can test this myself.
>>>      
>>>
>>Sure, patches attached.
>>
>>patch-6 is the one you are interested in for the different sizes
>>    
>>
>
>Thanks, it seems to work just fine. I have put the overflow and zero
>check changes in my kernel patch queue.
>
>However, I want to wait with the increased max packet size until the
>memory allocation strategy has been changed to avoid wasting lots of
>memory in the common cases. I will go work on a patch to do that now.
>
>  
>

