Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269858AbUIDJpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269858AbUIDJpc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269857AbUIDJpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:45:32 -0400
Received: from giesskaennchen.de ([83.151.18.118]:5800 "EHLO
	mail.uni-matrix.com") by vger.kernel.org with ESMTP id S269854AbUIDJpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:45:17 -0400
Message-ID: <41398EA2.3070304@giesskaennchen.de>
Date: Sat, 04 Sep 2004 11:45:06 +0200
From: Oliver Antwerpen <olli@giesskaennchen.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: Kernel Build error (objdump fails)
References: <41377705.9060305@giesskaennchen.de> <20040903165100.7bd6d3d6.akpm@osdl.org>
In-Reply-To: <20040903165100.7bd6d3d6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-giesskaennchen.de-MailScanner-Information: Die Giesskaennchen verschicken keine Viren!
X-giesskaennchen.de-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Oliver Antwerpen <olli@giesskaennchen.de> wrote:
> 
>>when compiling the linux kernel (I tried 2.6.8, 2.6.8.1, 2.6.9-rc1) I get:
>>
>>   CC      arch/i386/kernel/acpi/sleep.o
>>   AS      arch/i386/kernel/acpi/wakeup.o
>>   LD      arch/i386/kernel/acpi/built-in.o
>>arch/i386/kernel/acpi/boot.o: file not recognized: File truncated
>>make[2]: *** [arch/i386/kernel/acpi/built-in.o] Error 1
>>make[1]: *** [arch/i386/kernel/acpi] Error 2
>>make: *** [arch/i386/kernel] Error 2
> 
> 
> What kernel are you running when performing the build?
> 
> There's a bug in 2.6.9-rc1-mm1 which will cause the above.

Andrew,

You are right, I as running 2.6.9-rc1-mm1. As I found out this night, 
the bug only occurs under this kernel and only on ext3-Filesystems.
Thank you!


Ollfried


