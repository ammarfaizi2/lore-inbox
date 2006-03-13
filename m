Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWCMSPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWCMSPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWCMSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:15:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21721 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932301AbWCMSPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:15:35 -0500
Message-ID: <4415B6C0.8060405@namesys.com>
Date: Mon, 13 Mar 2006 10:15:28 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>, drepper@redhat.com
CC: Marr <marr@flex.com>, Linda Walsh <lkml@tlinx.org>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, Andrew Morton <akpm@osdl.org>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
 Calls From 2.4 to 2.6 -- VMM Change?)
References: <200602241522.48725.marr@flex.com> <200603121653.30288.marr@flex.com> <44149D6A.7080005@rtr.ca> <200603122336.55701.marr@flex.com> <441584AD.8060503@rtr.ca>
In-Reply-To: <441584AD.8060503@rtr.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich, what are your plans regarding fixing this?  Are you just going
to ignore it or?

Hans

Mark Lord wrote:

> Marr wrote:
>
>>
>> Anyway, not that it really matters, but I re-did the testing with
>> '-a0' and it didn't help one iota. The 2.6.13 kernel on ReiserFS
>> (without using 'nolargeio=1' as a mount option) still takes about
>> 4m35s to fseek 200,000 times on that 4MB file, even with 'hdparm -a0
>> /dev/hda' in effect.
>
>
> Does it make a difference when done on the filesystem *partition*
> rather than the base drive?  At one time, this mattered, and it may
> still work that way today.
>
> Eg.  hdparm -a0 /dev/hda3   rather than   hdparm -a0 /dev/hda
>
> ??
>
>

