Return-Path: <linux-kernel-owner+willy=40w.ods.org-S291732AbUKBIq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S291732AbUKBIq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276411AbUKBIq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:46:59 -0500
Received: from wasp.net.au ([203.190.192.17]:55731 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S454824AbUKBIpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:45:31 -0500
Message-ID: <4187494F.5090009@wasp.net.au>
Date: Tue, 02 Nov 2004 12:46:07 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8+ (X11/20041029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-bk page allocation failure. order:2, mode:0x20
References: <41873452.8040804@wasp.net.au> <41873F38.7030609@yahoo.com.au> <418742BE.4040200@wasp.net.au> <4187468E.3050709@yahoo.com.au>
In-Reply-To: <4187468E.3050709@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>> Always willing to test specific patches. Can I just grab the broken 
>> out patches, or pull some specific csets from a bk tree? I'm not 
>> particularly keen on running an -mm kernel on this box if I can avoid 
>> it (It's a server in 24hr use with 2.5TB of data where the backup 
>> media is 7,000km away).
>>
> 
> OK fair enough.
> 
> Here is a rollup of the 3 patches that are supposed to help with
> the problem. It is diffed against 2.6.10-rc1-bk8, which you probably
> wouldn't want to run either.
> 
> Not sure how cleanly it will apply onto 2.6.9... shouldn't be too bad
> I think.
>

I'm actually running a reasonably recent BK pull of 2.6.10-rc1 as of a couple of days ago, but I did 
some pretty severe testing and evaluation with my raid disks removed and replaced with spares before 
I let it loose on the real media. I have applied those patches and I'll beat on it for a few hours 
and see how it goes. I have some pretty defined cron jobs that make it easy to reproduce.

Regards,
Brad
