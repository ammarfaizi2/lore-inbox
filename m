Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbUKQT3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUKQT3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKQT2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:28:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:32178 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262438AbUKQTZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:25:31 -0500
Message-ID: <419BA2A1.3010703@osdl.org>
Date: Wed, 17 Nov 2004 11:12:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kraxel@bytesex.org, jelle@foks.8m.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cx88: fix printk arg. type
References: <419A89A3.90903@osdl.org>	<20041117172519.GB8176@bytesex>	<419B8EC0.2070005@osdl.org> <20041117112205.7272d362.akpm@osdl.org>
In-Reply-To: <20041117112205.7272d362.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>Gerd Knorr wrote:

>> Kernel supports/allows 'Z' or 'z'.
>> C99 spec defines 'z' only as a size_t format length modifier:
>>
>> z   Specifies that a following d, i, o, u, x, or X conversion 
>> specifier applies to a size_t or the corresponding signed integer type 
>> argument; or that a following n conversion specifier applies to a 
>> pointer to a signed integer type corresponding to size_t argument.
>>
>> Anyway, I agree with Al.  Will you please change it to
>> 'z' instead of 'Z'?
> 
> 
> gcc-2.95.x generates warnings for `z', but is happy with 'Z'.
> 
> But I seem to be the only person who uses 2.95, and I patched my version to
> stop that warning anyway, so...

Argh, I had forgotten that one....

-- 
~Randy
