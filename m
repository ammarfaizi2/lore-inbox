Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVA3Oju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVA3Oju (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 09:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVA3Oju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 09:39:50 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:62889 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261706AbVA3Ojs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 09:39:48 -0500
Message-ID: <41FCFED4.1070301@tiscali.de>
Date: Sun, 30 Jan 2005 16:35:48 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de>
In-Reply-To: <m1pszn3t2w.fsf@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Adrian Bunk <bunk@stusta.de> writes:
>
>  
>
>>With the release of gcc 4.0 being only a few months away and people 
>>already tring compiling with it, it's time for adding a compiler-gcc4.h .
>>
>>This patch contains the following changes:
>>- compiler-gcc+.h: add the missing noinline and __compiler_offsetof
>>- compiler-gcc4.h: new file based on the corrected compiler-gcc+.h
>>- compiler.h: include compiler-gcc4.h for gcc 4
>>- compiler-gcc3.h: remove __compiler_offsetof (there will never be a
>>                                               gcc 3.5)
>>                   small indention corrections
>>    
>>
>
>I don't think it makes much sense right now because it's basically
>identical to compiler-gcc3.h. I would only add it where there is a 
>need for a real difference.
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
But maybe gcc 4 will get different later, so I think this patch makes sense.

Matthias-Christian Ott
