Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWFTH1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWFTH1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 03:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbWFTH1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 03:27:30 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:19332 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965120AbWFTH13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 03:27:29 -0400
Message-ID: <4497A34C.2000104@ak.jp.nec.com>
Date: Tue, 20 Jun 2006 16:27:08 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
References: <449794BB.8010108@ak.jp.nec.com> <20060619234212.b95e5734.akpm@osdl.org>
In-Reply-To: <20060619234212.b95e5734.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi, I noticed three problems in pacct facility.
>>
>> 1. Pacct facility has a possibility to write incorrect ac_flag
>>    in multi-threading cases.
>> 2. There is a possibility to be waken up OOM Killer from
>>    pacct facility. It will cause system stall.
>> 3. If several threads are killed at same time, There is
>>    a possibility not to pick up a part of those accountings.
>>
>> The attached patch will resolve those matters.
>> Any comments please. Thanks,
> 
> Thanks, but you have three quite distinct bugs here, and three quite
> distinct descriptions and, I think, three quite distinct fixes.
> 
> Would it be possible for you to prepare three patches?

It may be possible. Please wait for a while to separate it into
three-part and to confirm its correct behavior.

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
