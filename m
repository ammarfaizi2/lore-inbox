Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVCXFoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVCXFoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVCXFoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:44:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:14057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbVCXFo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:44:27 -0500
Message-ID: <4242538A.10200@osdl.org>
Date: Wed, 23 Mar 2005 21:43:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
 (2.6.11)
References: <20050315133644.GA25903@beast>	<20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <42424D52.7070508@pobox.com>
In-Reply-To: <42424D52.7070508@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
> 
>> David McCullough <davidm@snapgear.com> wrote:
>>
>>> Here is a small patch for 2.6.11 that adds a routine:
>>>
>>>     add_true_randomness(__u32 *buf, int nwords);
>>
>>
>>
>> It neither applies correctly nor compiles in current kernels.  2.6.11 is
>> very old in kernel time.
> 
> 
> Hrm.  This is getting pretty lame, if you can't take patches from the 
> -latest- stable release.  It's pretty easy in BK:
> 
>     bk clone -ql -rv2.6.11 linux-2.6 rng-2.6.11
>     cd rng-2.6.11
>     { apply patch }
>     bk pull ../linux-2.6
> 
> Can you set up something like that?

I thought that the latest stable release was 2.6.11.5.

However, what I really want to do is ask what patches should be
made against.  I suggested on linux-scsi a day or 2 ago that
they should be made against the latest linus-bk (or snapshot)
unless the patch only applies to -mm, then they should obviously
be made against -mm.  2.6.11 plain is relatively aged IMO also....

-- 
~Randy
