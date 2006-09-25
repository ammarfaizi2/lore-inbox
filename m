Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWIYWuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWIYWuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWIYWun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:50:43 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16188 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751358AbWIYWun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:50:43 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=lcdJslGOPg7XP4NT8AqQdxi/2ina1p49E8tbwTYT63HEXxEX+fK/sYBPCdgimG3Ri
	fs/GPV+S0SzaooSX1YiYQ==
Message-ID: <45185D28.30009@google.com>
Date: Mon, 25 Sep 2006 15:50:16 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com> <45185B7A.4020809@garzik.org>
In-Reply-To: <45185B7A.4020809@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Martin Bligh wrote:
> 
>> http://test.kernel.org/abat/49037/debug/test.log.0  
>>   AS      arch/x86_64/boot/bootsect.o
>>   LD      arch/x86_64/boot/bootsect
>>   AS      arch/x86_64/boot/setup.o
>>   LD      arch/x86_64/boot/setup
>>   AS      arch/x86_64/boot/compressed/head.o
>>   CC      arch/x86_64/boot/compressed/misc.o
>>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
>> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) 
>> file offset 0x804700c0.
>> /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy: 
>> arch/x86_64/boot/compressed/vmlinux.bin: File truncated
> 
> 
> Did you run out of disk space?

Possibly, though it's meant to check that before it starts.
Very odd error message though.

Andy ... any chance you can poke that box and see?

M.
