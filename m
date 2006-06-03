Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWFCVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWFCVGA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWFCVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:06:00 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:6154 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751272AbWFCVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:06:00 -0400
Message-ID: <4481F9B3.2020703@gmail.com>
Date: Sat, 03 Jun 2006 22:05:55 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc5 7/8] Remove some of the kmemleak false positives
References: <20060603081054.31915.4038.stgit@localhost.localdomain> <20060603081134.31915.37367.stgit@localhost.localdomain> <20060603204808.GB4629@ucw.cz>
In-Reply-To: <20060603204808.GB4629@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>From: Catalin Marinas <catalin.marinas@arm.com>
>>+		memleak_debug_not_leak(res);
> 
> I'd suggest some shorter/more generic name.
> 
> 	not_freed(res); ?
> 
> 	alloc_forever(res); ?

It's true that the names are a bit long ("debug" is even superfluous). I
would, however, keep the memleak_ prefix as I think it makes the code
clearer (i.e. the function belongs to a certain part of the kernel).

Catalin
