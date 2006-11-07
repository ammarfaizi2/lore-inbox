Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752984AbWKGKfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbWKGKfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbWKGKft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:35:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:62249 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752984AbWKGKft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:35:49 -0500
Message-ID: <45506177.1070706@sw.ru>
Date: Tue, 07 Nov 2006 13:35:35 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3-mm1: compilation fails if CONFIG_KEVENT is disabled
References: <45487246.2080309@sw.ru> <20061107101506.GA26943@2ka.mipt.ru>
In-Reply-To: <20061107101506.GA26943@2ka.mipt.ru>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Wed, Nov 01, 2006 at 01:09:10PM +0300, Vasily Averin (vvs@sw.ru) wrote:
>> arch/i386/kernel/built-in.o(.rodata+0x520): In function `sys_call_table':
>> : undefined reference to `sys_kevent_get_events'
>> arch/i386/kernel/built-in.o(.rodata+0x524): In function `sys_call_table':
>> : undefined reference to `sys_kevent_ctl'
>> arch/i386/kernel/built-in.o(.rodata+0x528): In function `sys_call_table':
>> : undefined reference to `sys_kevent_wait'
>> make: *** [.tmp_vmlinux1] Error 1
>> [linux-2.6.19-rc3-mm1]$ grep KEVENT .config
>> CONFIG_GENERIC_CLOCKEVENTS=y
>> # CONFIG_KEVENT is not set
> 
> Could you send output of
> cat kernel/sys_ni.c | grep kevent 
> there should be all above syscalls, but it looks like they are not.

Sorry, I've switched to new kernels and removed your tree already. :(

Thank you,
	Vasily Averin
