Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbUJ0Uym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUJ0Uym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbUJ0Uwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:52:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:56294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262707AbUJ0Ugn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:36:43 -0400
Date: Wed, 27 Oct 2004 13:34:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm1 (compile stats)
Message-Id: <20041027133443.62b1fb29.akpm@osdl.org>
In-Reply-To: <1098895320.9269.32.camel@cherrybomb.pdx.osdl.net>
References: <20041026213156.682f35ca.akpm@osdl.org>
	<1098895320.9269.32.camel@cherrybomb.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry <cherry@osdl.org> wrote:
>
>  Build error is still...
> 
>    LD      vmlinux
>    SYSMAP  System.map
>    SYSMAP  .tmp_System.map
>    AS      arch/i386/boot/bootsect.o
>    AS      arch/i386/boot/compressed/head.o
>    AS      arch/i386/boot/setup.o
>    HOSTCC  arch/i386/boot/tools/build
>    CC      arch/i386/boot/compressed/misc.o
>    LD      arch/i386/boot/bootsect
>    OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>  BFD: Warning: Writing section `.bss' to huge (ie negative) file offset 0xc02e4000.
>  objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated

I think that means you need a binutils upgrade.  What version are you running?
