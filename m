Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269986AbUICXsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269986AbUICXsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269991AbUICXsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:48:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:11446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269986AbUICXrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:47:23 -0400
Date: Fri, 3 Sep 2004 16:51:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oliver Antwerpen <olli@giesskaennchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Build error (objdump fails)
Message-Id: <20040903165100.7bd6d3d6.akpm@osdl.org>
In-Reply-To: <41377705.9060305@giesskaennchen.de>
References: <41377705.9060305@giesskaennchen.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Antwerpen <olli@giesskaennchen.de> wrote:
>
> when compiling the linux kernel (I tried 2.6.8, 2.6.8.1, 2.6.9-rc1) I get:
> 
>    CC      arch/i386/kernel/acpi/sleep.o
>    AS      arch/i386/kernel/acpi/wakeup.o
>    LD      arch/i386/kernel/acpi/built-in.o
> arch/i386/kernel/acpi/boot.o: file not recognized: File truncated
> make[2]: *** [arch/i386/kernel/acpi/built-in.o] Error 1
> make[1]: *** [arch/i386/kernel/acpi] Error 2
> make: *** [arch/i386/kernel] Error 2

What kernel are you running when performing the build?

There's a bug in 2.6.9-rc1-mm1 which will cause the above.
