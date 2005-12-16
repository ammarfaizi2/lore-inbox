Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVLPMuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVLPMuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVLPMuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:50:55 -0500
Received: from tristate.vision.ee ([194.204.30.144]:52695 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S932232AbVLPMuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:50:54 -0500
Message-ID: <43A2B82C.2060403@vision.ee>
Date: Fri, 16 Dec 2005 14:50:52 +0200
From: =?UTF-8?B?TGVuYXIgTMO1aG11cw==?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
References: <20051214234016.0112a86e.akpm@osdl.org>
In-Reply-To: <20051214234016.0112a86e.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>mm/ microoptimisations
>
>-mm-implement-swap-prefetching.patch
>-mm-implement-swap-prefetching-default-y.patch
>-mm-implement-swap-prefetching-tweaks.patch
>-mm-implement-swap-prefetching-tweaks-2.patch
>-mm-swap-prefetch-magnify.patch
>
> Dropped swap prefetching, sorry.  I wasn't able to notice much benefit from
> it in my testing, and the number of mm/ patches in getting crazy, so we don't
> have capacity for speculative things at present.
>
For me it seems it is not so speculative. It really has effect when 
running with not-so-uber
memory/machine configuration.

After some big compile during lunch-time everything slowly crawls back 
to the screen when
I enter my password to unlock screen without these patches.

But with these applied I came back from my lunch and everything is as 
snappy as it was when
I left it.

This is with 256M of memory and old Duron CPU in machine. Hard disk 
being not too speedy either.

So, I'm really sorry to see these patches dropped instead pushing 
towards mainline.

Lenar

