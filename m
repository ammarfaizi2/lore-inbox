Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUEQOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUEQOnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUEQOnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:43:11 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:16132 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261468AbUEQOnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:43:08 -0400
Message-ID: <40A8CF85.8080507@hp.com>
Date: Mon, 17 May 2004 10:43:17 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jkillius@arcor.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
References: <200405161901.46375.jkillius@arcor.de>
In-Reply-To: <200405161901.46375.jkillius@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Killius wrote:

>Hello,
>there is a problem if CONFIG_HPET_EMULATE_RTC is enabled on a x86-64 system.
>Here is the error:
>make[1]: `arch/x86_64/kernel/asm-offsets.s' is up to date.
>  CHK     include/linux/compile.h
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>arch/x86_64/kernel/built-in.o(.text+0x87e9): In function `hpet_rtc_interrupt':
>: undefined reference to `rtc_interrupt'
>
>  
>
Hi,

I tried reproducing this on i386 but no luck.   Would you please send me 
your .config file.

thanks,

Bob

