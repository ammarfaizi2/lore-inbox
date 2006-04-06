Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWDFWu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWDFWu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWDFWu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:50:26 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:47032 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932196AbWDFWuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:50:24 -0400
Date: Thu, 6 Apr 2006 17:51:31 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem building UML kernel with 2.6.16.1 -- dies when linking vmlinux
Message-ID: <20060406215131.GA6422@ccure.user-mode-linux.org>
References: <443580A4.1020806@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443580A4.1020806@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 02:57:08PM -0600, Christopher Friesen wrote:
>         gcc -static -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc 
> -o vmlinux -Wl,-T,arch/um/kernel/vmlinux.lds   init/built-in.o 
> -Wl,--start-group  usr/built-in.o  arch/um/kernel/built-in.o 
> arch/um/drivers/built-in.o  arch/um/os-Linux/built-in.o 
> arch/um/sys-i386/built-in.o  arch/i386/crypto/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  block/built-in.o  lib/lib.a 
> lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o 
> -Wl,--end-group -lutil .tmp_kallsyms2.o ; rm -f linux
> collect2: ld returned 1 exit status

You can't extract an error message from that somehow?

There isn't much to go on there.

				Jeff
