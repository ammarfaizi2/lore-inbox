Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVAWSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVAWSYp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 13:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVAWSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 13:24:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:34765 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261282AbVAWSYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 13:24:35 -0500
Message-ID: <41F3E9FE.6050206@osdl.org>
Date: Sun, 23 Jan 2005 10:16:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: use UL on TASK_SIZE
References: <20050122225617.35d1c6ac.rddunlap@osdl.org> <20050123105903.GA2788@wotan.suse.de>
In-Reply-To: <20050123105903.GA2788@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sat, Jan 22, 2005 at 10:56:17PM -0800, Randy.Dunlap wrote:
> 
>>Use UL on large constant (kills 3214 sparse warnings :)
>>
>>include/linux/sched.h:1150:18: warning: constant 0x800000000000 is so big it is long
> 
> 
> Sounds more like a sparse bug to me.  The C99 standard says the type
> of the constant is the first in which the constant can be represented.
> And that list includes unsigned long and even unsigned long long.

Thanks,  I'll take it up on the sparse m-l.

-- 
~Randy
