Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267172AbSLQWae>; Tue, 17 Dec 2002 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLQWae>; Tue, 17 Dec 2002 17:30:34 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:6644 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S267172AbSLQWac>; Tue, 17 Dec 2002 17:30:32 -0500
Message-ID: <3E001825.7080709@centurytel.net>
Date: Tue, 17 Dec 2002 23:39:33 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Bob Miller <rem@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
References: <3E058049@zathras> <20021217211618.GB1069@doc.pdx.osdl.net>
In-Reply-To: <20021217211618.GB1069@doc.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Miller wrote:
> On Tue, Dec 17, 2002 at 03:57:01PM -0500, rtilley wrote:
> 
>>Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It keeps 
>>returning this error on 2 totally different x86 PCs:
>>
>>
>>drivers/built-in.o: In function `kd_nosound':
>>drivers/built-in.o(.text+0x1883f): undefined reference to `input_event'
>>drivers/built-in.o(.text+0x18861): undefined reference to `input_event'
>>drivers/built-in.o: In function `kd_mksound':
>>drivers/built-in.o(.text+0x1890a): undefined reference to `input_event'
>>drivers/built-in.o: In function `kbd_bh':
>>drivers/built-in.o(.text+0x197a2): undefined reference to `input_event'
>>drivers/built-in.o(.text+0x197c1): undefined reference to `input_event'
>>drivers/built-in.o(.text+0x197e0): more undefined references to `input_event' 
>>follow
>>drivers/built-in.o: In function `kbd_connect':
>>drivers/built-in.o(.text+0x19d54): undefined reference to `input_open_device'
>>drivers/built-in.o: In function `kbd_disconnect':
>>drivers/built-in.o(.text+0x19d7f): undefined reference to `input_close_device'
>>drivers/built-in.o: In function `kbd_init':
>>drivers/built-in.o(.init.text+0x12c1): undefined reference to 
>>`input_register_handler'
>>make: *** [.tmp_vmlinux1] Error 1
>>
>>
>>Where is the fix for this?
>>
> 
> At your finger tips ;-).  Turn on CONFIG_INPUT via "Input device support"
> off the main page.
I did not know what is that mean (off the man page)?
> 
Is that at menuconfig
or
should modify any source code?


-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

