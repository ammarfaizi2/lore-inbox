Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWIYWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWIYWnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWIYWnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:43:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63956 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751568AbWIYWnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:43:18 -0400
Message-ID: <45185B7A.4020809@garzik.org>
Date: Mon, 25 Sep 2006 18:43:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
References: <45185A93.7020105@google.com>
In-Reply-To: <45185A93.7020105@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> http://test.kernel.org/abat/49037/debug/test.log.0   
> 
>   AS      arch/x86_64/boot/bootsect.o
>   LD      arch/x86_64/boot/bootsect
>   AS      arch/x86_64/boot/setup.o
>   LD      arch/x86_64/boot/setup
>   AS      arch/x86_64/boot/compressed/head.o
>   CC      arch/x86_64/boot/compressed/misc.o
>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file 
> offset 0x804700c0.
> /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy: 
> arch/x86_64/boot/compressed/vmlinux.bin: File truncated

Did you run out of disk space?

	Jeff



