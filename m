Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbTFRXVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbTFRXVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:21:11 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23424 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265607AbTFRXVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:21:01 -0400
Date: Wed, 18 Jun 2003 16:35:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, sam@ravnborg.org
Subject: Re: common name for the kernel DSO
Message-Id: <20030618163551.0cd6b867.akpm@digeo.com>
In-Reply-To: <16112.60671.410179.275282@napali.hpl.hp.com>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
	<20030618203247.GA14124@mars.ravnborg.org>
	<16112.60671.410179.275282@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 23:34:59.0179 (UTC) FILETIME=[3B6BE3B0:01C335F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> +++ edited/arch/i386/kernel/Makefile	Wed Jun 18 15:47:48 2003
>  @@ -47,7 +47,7 @@
>         cmd_syscall = $(CC) -nostdlib $(SYSCFLAGS_$(@F)) \
>   		          -Wl,-T,$(filter-out FORCE,$^) -o $@
>   
>  -vsyscall-flags = -shared -s -Wl,-soname=linux-vsyscall.so.1
>  +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1

What happens if one architecture decides to take this up to
linux-gate.so.2?  If that is even a legit thing to do.
