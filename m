Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVEKLIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEKLIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 07:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVEKLIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 07:08:09 -0400
Received: from [195.23.16.24] ([195.23.16.24]:30426 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261207AbVEKLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 07:08:04 -0400
Message-ID: <4281E78B.2030103@grupopie.com>
Date: Wed, 11 May 2005 12:07:55 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
References: <20050510161657.3afb21ff.akpm@osdl.org> <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org> <20050510.170946.10291902.davem@davemloft.net> <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost> <20050510172913.2d47a4d4.akpm@osdl.org> <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Tue, 10 May 2005, Andrew Morton wrote:
> 
>>Jesper Juhl <juhl-lkml@dif.dk> wrote:
>>
>>>[...]
>>> Ohh, and I'd be submitting all the patches to you Andrew, not individual 
>>> maintainers/authors..
>>
>>That should be OK - you can test that the .o files have the same `size'
>>output before-and-after.
>>
>>[...]
> 
> Ok, will do.

Just a small sugestion: do a sha (or md5sum, or whatever hash function 
you prefer) to vmlinux before and after applying the patches.

If all is well, it shouldn't change (since this is just whitespace 
cleanup), and it is a little more robust than just checking the size.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
