Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUKBTRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUKBTRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUKBTRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:17:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:62940 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261292AbUKBTRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:17:06 -0500
Message-ID: <4187DA9B.8060401@osdl.org>
Date: Tue, 02 Nov 2004 11:06:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: =?UTF-8?B?UGF3ZcWCIFNpa29yYQ==?= <pluto@pld-linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
References: <200411020719.55570.pluto@pld-linux.org> <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr> <200411021934.38802.pluto@pld-linux.org> <Pine.LNX.4.53.0411021937460.13120@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411021937460.13120@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>You do know that %s does not mix with 1.4?
>>
>>Yes, I known. I did it intentionally.

And you intentionally ignored the gcc warning...
it's all yours.
I.e., a normal user couldn't load the kernel module.

>>IMHO kernel should be more resistant to accidental programmers errors.
>>Be secure, trust no one ;)
> 
> 
> Well usually it should be. include/linux/kernel.h has the __attribute__(printf)
> stuff for the print[fk]* family.


-- 
~Randy
