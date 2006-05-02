Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWEBTVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWEBTVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEBTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:21:47 -0400
Received: from nijmegen.renzel.net ([195.243.213.130]:53423 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1750769AbWEBTVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:21:47 -0400
Message-ID: <4457B102.7020802@linuxtv.org>
Date: Tue, 02 May 2006 21:20:34 +0200
From: Marcel Siegert <mws@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, js@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
References: <20060430174426.a21b4614.rdunlap@xenotime.net>  <1146503166.2885.137.camel@hades.cambridge.redhat.com>  <20060502003755.GA26327@linuxtv.org>  <1146576495.14059.45.camel@pmac.infradead.org>  <20060502142050.GC27798@linuxtv.org>  <1146580308.17934.19.camel@pmac.infradead.org>  <20060502101113.17c75a05.rdunlap@xenotime.net>  <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org> <1146595853.19101.38.camel@pmac.infradead.org> <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 2 May 2006, David Woodhouse wrote:
> 
>>On Tue, 2006-05-02 at 11:41 -0700, Linus Torvalds wrote:
>>
>>>The problem with uint32_t is that it's ugly, it used to be unportable, and 
>>>you can't use it in header files _anyway_.
>>
>>Unportable? It's at least as portable as u32 is, surely? We probably
>>wouldn't have used <stdint.h> in the kernel anyway -- we define them
>>ourselves. 
> 
> 
> When the u<n> things were done, uint<n>_t wasn't at all common. 
> 
> 
>>The header files are completely irrelevant too -- we're talking about
>>'u32' not '__u32'.
> 
> 
> That's not irrelevant. Usually you want to have stuff in header files that 
> you use in source code. You want the two to visually look similar. It's a 
> hell of a lot less confusing to use "u32" (in source) and "__u32" (in the 
> header file), than it is to mix "uint32_t" (in source) and some random 
> other thing (in header file).

isn't it possible to mix up u32 and some random other thing?
> 
>>The important thing is your belief that it's ugly, which is what was
>>documented.
> 
> 
> And that wasn't what I objected to. 
> 
> What I objected to was that other part, which said that "uint32_t" was 
> somehow more standard.
> 
> IN THE KERNEL IT IS _LESS_ STANDARD.
> 
> And outside the kernel, that documentation is not exactly relevant.

nack. something is a standard or something is not. black or white. grey isn't there.
of course, you are free to create your own kernel standard or whatever.
what about __uint32_t? *scnr*

marcel


> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

