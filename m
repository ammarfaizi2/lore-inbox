Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbUKEO7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUKEO7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 09:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUKEO7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 09:59:33 -0500
Received: from mail3.utc.com ([192.249.46.192]:5512 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262707AbUKEO7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 09:59:09 -0500
Message-ID: <418B9527.4050100@cybsft.com>
Date: Fri, 05 Nov 2004 08:58:47 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amitshah@gmx.net>
Subject: Re: RT-preempt-2.6.10-rc1-mm2-V0.7.11 hang
References: <200411051837.02083.amitshah@gmx.net> <20041105134639.GA14830@elte.hu> <200411051142.43394.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200411051142.43394.norberto+linux-kernel@bensa.ath.cx>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:
> Ingo Molnar wrote:
> 
>>* Amit Shah <amitshah@gmx.net> wrote:
>>
>>>I'm trying out the RT preempt patch on a P4 HT machine, I get the
>>>following message:
>>>
>>
>>hm, does this happen with -V0.7.13 too? (note that it's against
>>2.6.10-rc1-mm3, a newer -mm tree.)
> 
> 
> But it doesn't -cleanly- apply. 
> 
> Hunk #2 FAILED at 1545.
> 1 out of 2 hunks FAILED -- saving rejects to file mm/mmap.c.rej
> 
> Regards,
> Norberto

It looks to me like this fails because it is already in -mm3. Probably 
can safely ignore this.

kr
