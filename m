Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVEZHFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVEZHFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVEZHFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:05:54 -0400
Received: from dvhart.com ([64.146.134.43]:51363 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261232AbVEZHFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:05:39 -0400
Date: Thu, 26 May 2005 00:05:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <191140000.1117091133@[10.10.2.4]>
In-Reply-To: <20050525234717.261beb48.akpm@osdl.org>
References: <175590000.1117089446@[10.10.2.4]> <20050525234717.261beb48.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andrew Morton <akpm@osdl.org> wrote (on Wednesday, May 25, 2005 23:47:17 -0700):

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>> 
>> Build failure on numaq:
>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
>> 
>>  In file included from include/linux/sched.h:12,
>>                   from arch/i386/kernel/asm-offsets.c:7:
>>  include/linux/jiffies.h:42:3: #error You lose.
> 
> You lost!  CONFIG_HZ didn't get set.
> 
> Something obviously went wrong in the magic in kernel/Kconfig.hz.  Wanna do
> `grep HZ .config' and see if you can work out why it broke?

Tis conspicious by it's absence.

mbligh@kernel:~/linux-2.6.12-rc5-mm1$ grep HZ .config
mbligh@kernel:~/linux-2.6.12-rc5-mm1$ 

I'll poke at it in the morning, with the benfits of less wine, and more 
sleep

M.

