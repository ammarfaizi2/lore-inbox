Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUFSKPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUFSKPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFSKPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:15:19 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:45876 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265360AbUFSKPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:15:12 -0400
Message-ID: <40D411AE.4080704@travellingkiwi.com>
Date: Sat, 19 Jun 2004 11:13:02 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, michal@harddata.com
Subject: Re: acpi S3 never wakes up
References: <20040618154025.15708106@damned.travellingkiwi.com> <40D34F90.1060907@travellingkiwi.com> <20040619085124.GC8930@k3.hellgate.ch>
In-Reply-To: <20040619085124.GC8930@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:

>On Fri, 18 Jun 2004 21:24:48 +0100, Hamie wrote:
>  
>
>>Can anyone give me a hint as to where the kernel should be 
>>re-initialising the video?
>>    
>>
>
>Have you checked Documentation/power/video.txt? It's not terribly
>encouraging, but it may give you some answers.
>
>  
>

Thanks for that. I missed it. Apologies to the list for not looking more 
before I threw the toys. Also thanks to michal@harddata.com who gave the 
one that works for the Thinkpad.

In case anyone else is looking, the r50p will resume from S3 when

acpi_sleep=s3_bios

is specified as a boot option.

Shame about the ATI drivers not restoring, but XOrg's X server works 
like a charm (Apart from no hardware 3D acceleration for the FireGL-T2). 
Still, I suppose I don't have a tainted kernel any more :)

H


