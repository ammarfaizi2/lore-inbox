Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHBVyJ>; Fri, 2 Aug 2002 17:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSHBVyI>; Fri, 2 Aug 2002 17:54:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62056 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317257AbSHBVyI>; Fri, 2 Aug 2002 17:54:08 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208022157.g72Lv3G31399@devserv.devel.redhat.com>
Subject: Re: Accelerating user mode linux
To: jdike@karaya.com (Jeff Dike)
Date: Fri, 2 Aug 2002 17:57:03 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200208022233.RAA04165@ccure.karaya.com> from "Jeff Dike" at Aug 02, 2002 05:33:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mmap, munmap, and mprotect by adding another argument, I'm not.  I'm talking
> about adding new syscalls, mmap2, munmap2, mprotect2 (or something more
> imaginative), which have the extra argument, having them take -1 as meaning
> "fiddle the current address space" and pursuading libc to use them instead
> of the current syscalls.  Then we would start the current ones on their way
> to the happy syscall hunting grounds in the sky.

Thats a lot more invasive than I want to be
