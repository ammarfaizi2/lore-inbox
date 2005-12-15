Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVLOWLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVLOWLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVLOWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:11:47 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:53126 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751150AbVLOWLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:11:46 -0500
Message-ID: <43A1D52F.7070707@wolfmountaingroup.com>
Date: Thu, 15 Dec 2005 13:42:23 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org>
In-Reply-To: <20051215140013.7d4ffd5b.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew,

Thanks. I concur.

Jeff

Andrew Morton wrote:

>Adrian Bunk <bunk@stusta.de> wrote:
>  
>
>>This patch was already sent on:
>>- 11 Dec 2005
>>- 5 Dec 2005
>>- 30 Nov 2005
>>- 23 Nov 2005
>>- 14 Nov 2005
>>    
>>
>
>Sigh.  I saw the volume of email last time and though "gee, glad I wasn't
>cc'ed on that lot".
>
>Supporting 8k stacks is a small amount of code and nobody has seen a need
>to make changes in there for quite a long time.  So there's little cost to
>keeping the existing code.
>
>And the existing code is useful:
>
>a) people can enable it to confirm that their weird crash was due to a
>   stack overflow.
>
>b) If I was going to put together a maximally-stable kernel for a
>   complex server machine, I'd select 8k stacks.  We're still just too
>   squeezy, and we've had too many relatively-recent overflows, and there
>   are still some really deep callpaths in there.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

