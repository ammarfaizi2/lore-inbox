Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbULPOg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbULPOg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbULPOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:35:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:3793 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262670AbULPObd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:31:33 -0500
Message-ID: <41C19B4C.8030201@dif.dk>
Date: Thu, 16 Dec 2004 15:27:24 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parent
 heses
References: <200412161116.31607.arnd@arndb.de>
In-Reply-To: <200412161116.31607.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Dunnersdag 16 Dezember 2004 01:02, Jesper Juhl wrote:
> 
>>If these patches are generally acceted then I think it would make
> 
> sense to 
> 
>>make a small addition to Documentation/CodingStyle mentioning the
> 
> prefered 
> 
>>form of return statements, so we (hopefully) won't have to do cleanups
> 
> 
>>like this too often in the future.
>>Below I've included a proposed patch adding such a bit to CodingStyle.
> 
> I think the change in Documentation/CodingStyle is useful, even though I
> don't really like changing all the existing code without going through
> the respective maintainers.
> 
I guess you have a point. I won't submit more of these through LKML but 
will stick to working with maintainers.
These first 30 patches were mostly meant to "test the waters".

I'm glad you like the addition to CodingStyle. :)

> 
> This is basically the same category as the first three chapters of
> CodingStyle. It's not nice to read, but there is no real problem in the 
> code. Think of these issues as whitespace fixes: you are making the job
> harder for code maintainers for very little gain. I would suggest that
> you submit these patches only to the code maintainers, not to the
> Trivial
> Patch Monkey or Andrew.

Will do.


> Or even better, change scripts/Lindent to do the change automatically
> for
> code that it is used on, if that can be done in a reliable way.
>  Arnd <><

I've never actually looked at how that script does its work, guess now's 
a good time to start looking :)


-- 
Jesper Juhl
