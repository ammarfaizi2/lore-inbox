Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWH2NNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWH2NNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWH2NNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:13:39 -0400
Received: from boutiquenumerique.com ([82.67.9.10]:35529 "EHLO peufeu.com")
	by vger.kernel.org with ESMTP id S964838AbWH2NNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:13:39 -0400
Date: Tue, 29 Aug 2006 15:14:42 +0200
To: "Andrew Morton" <akpm@osdl.org>, "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: Reiser4 und LZO compression
From: PFC <lists@peufeu.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <20060827003426.GB5204@martell.zuzino.mipt.ru> <20060827010428.5c9d943b.akpm@osdl.org>
Content-Transfer-Encoding: 7bit
Message-ID: <op.te1q2sfbcigqcu@apollo13>
In-Reply-To: <20060827010428.5c9d943b.akpm@osdl.org>
User-Agent: Opera Mail/9.00 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	Would it be, by any chance, possible to tweak the thing so that reiserfs  
plugins become kernel modules, so that the reiserfs core can be put in the  
kernel without the plugins slowing down its acceptance ?

	(and updating plugins without rebooting would be a nice extra)

>> The patch below is so-called reiser4 LZO compression plugin as extracted
>> from 2.6.18-rc4-mm3.
>>
>> I think it is an unauditable piece of shit and thus should not enter
>> mainline.
>
> Like lib/inflate.c (and this new code should arguably be in lib/).
>
> The problem is that if we clean this up, we've diverged very much from  
> the
> upstream implementation.  So taking in fixes and features from upstream
> becomes harder and more error-prone.
>
> I'd suspect that the maturity of these utilities is such that we could
> afford to turn them into kernel code in the expectation that any future
> changes will be small.  But it's not a completely simple call.
>
> (iirc the inflate code had a buffer overrun a while back, which was found
> and fixed in the upstream version).
>
>


