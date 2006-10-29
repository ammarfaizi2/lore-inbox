Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWJ2AFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWJ2AFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 20:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWJ2AFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 20:05:22 -0400
Received: from mail.tmr.com ([64.65.253.246]:35783 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751426AbWJ2AFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 20:05:21 -0400
Message-ID: <4543F01F.2010606@tmr.com>
Date: Sat, 28 Oct 2006 20:04:47 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Thaw userspace and kernel space separately.
References: <1161560896.7438.67.camel@nigel.suspend2.net> <20061023151845.GB8414@elf.ucw.cz>
In-Reply-To: <20061023151845.GB8414@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> Modify process thawing so that we can thaw kernel space without thawing
>> userspace, and thaw kernelspace first. This will be useful in later
>> patches, where I intend to get swsusp thawing kernel threads only before
>> seeking to free memory.
>>
>> Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> 
> NAK. "May be useful in future" is not good reason to merge it now. (If
> you did not want it merged, just mark it so).

I hope Nigel will keep working at it, since low memory machines like old 
laptops would benefit from suspend are a reality. It can be kept as a 
separate patch somewhere, like suspend2, which people can patch in to 
enhance the example code currently in the kernel.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
