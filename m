Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbULLXB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbULLXB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbULLXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:01:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:4785 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262163AbULLXBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:01:21 -0500
Message-ID: <41BCCCAA.800@osdl.org>
Date: Sun, 12 Dec 2004 14:56:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWFyY2luIEdpYnXCs2E=?= <mg@iceni.pl>
CC: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: STIr4200 warnings
References: <200412121153.33981@senat> <200412121227.34503@senat> <200412121313.23605.oliver@neukum.org> <200412122309.51065@senat>
In-Reply-To: <200412122309.51065@senat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Gibuła wrote:
>>>>The newest kernel does just that. Can you update and retest?
>>>
>>>You mean 2.6.10-rc3-bk6 ?
>>
>>Presumably. I did an update yesterday and found it corrcted.
> 
> 
> Unfortunately, I can't build it :/
> 
>   CC      fs/buffer.o
> fs/buffer.c: In function `sys_fdatasync':
> fs/buffer.c:401: error: `PF_SYNCTHREAD' undeclared (first use in this 
> function)
> fs/buffer.c:401: error: (Each undeclared identifier is reported only once
> fs/buffer.c:401: error: for each function it appears in.)
> 
> .config attached

I'm not seeing  a problem with your .config or with mine.
I'd be suspecting something else, like corrupted tarball
or not applied correctly, or whatever.

My copy of fs/buffer.c does not contain PF_SYNCTHREAD
on line 401 (or anywhere in that source file).

-- 
~Randy
