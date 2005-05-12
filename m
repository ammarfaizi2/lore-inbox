Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVELMRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVELMRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVELMRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:17:04 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44420 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261297AbVELMQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:16:57 -0400
Message-ID: <42834935.9060404@grupopie.com>
Date: Thu, 12 May 2005 13:16:53 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
References: <20050510161657.3afb21ff.akpm@osdl.org> <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org> <20050510.170946.10291902.davem@davemloft.net> <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost> <20050510172913.2d47a4d4.akpm@osdl.org> <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost> <4281E78B.2030103@grupopie.com> <20050511225657.GM6884@stusta.de>
In-Reply-To: <20050511225657.GM6884@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, May 11, 2005 at 12:07:55PM +0100, Paulo Marques wrote:
> [...]
>>Just a small sugestion: do a sha (or md5sum, or whatever hash function 
>>you prefer) to vmlinux before and after applying the patches.
>>
>>If all is well, it shouldn't change (since this is just whitespace 
>>cleanup), and it is a little more robust than just checking the size.
> 
> That's wrong.
> 
> vmlinux contains the date of the compilation.

You're right, I forgot about that...

Removing UTS_VERSION from init/version.c would make this work, or are 
there other places where this might be a problem?

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
