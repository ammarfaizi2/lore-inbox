Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRKEXSW>; Mon, 5 Nov 2001 18:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281424AbRKEXSC>; Mon, 5 Nov 2001 18:18:02 -0500
Received: from babel.spoiled.org ([217.13.197.48]:33699 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S281420AbRKEXSA>;
	Mon, 5 Nov 2001 18:18:00 -0500
From: Juri Haberland <juri@koschikode.com>
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Cc: linux-kernel@vger.kernel.org, dz@debian.org, stephane@tuxfinder.org
Subject: Re: [PATCH] SMM BIOS on Dell i8100
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <3BE6B869.D79E93B1@mandrakesoft.com>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20011105231759.02B541195E@a.mx.spoiled.org>
Date: Tue,  6 Nov 2001 00:17:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE6B869.D79E93B1@mandrakesoft.com> you wrote:
> Stephane Jourdois wrote:
>> 
>> Hello,
>> 
>> First, a very big thanx to Massimo for this great piece of code :-)
>> I've been trying to catch those events with no sucess for weeks.
>> 
>> I've got a Dell Inspiron 8100, which seems to differ slightly from
>> i8000. Here is a patch that fixes that. Please do not hesitate to ask me
>> to test some new code or anything on my laptop.
>> 
>> You should also replace your printk("string") with printk(KERN_INFO "string")
> 
> Has this been tested in I8000?  You are changing a lot of magic numbers
> in the code, and noone but you/Massimo know whether that is ok or not...

Actually, I just tried plain 2.4.14-pre8 and the i8k-module *didn't*
work with my i8000, but with the patch from Stephane it *does* ;)

Happy happy, joy joy...

Juri

PS: BIOS verion A17 if that matters

-- 
Juri Haberland  <juri@koschikode.com> 

