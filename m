Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTJaPyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJaPyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:54:23 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:24240 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S263373AbTJaPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:54:17 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Post-halloween doc updates.
Date: Fri, 31 Oct 2003 16:53:45 +0100
User-Agent: KMail/1.5.4
References: <20031030141519.GA10700@redhat.com>
In-Reply-To: <20031030141519.GA10700@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310311653.45562.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
hi lkml,

On Thursday 30 October 2003 15:15, Dave Jones wrote:
> Threading improvements.
> ~~~~~~~~~~~~~~~~~~~~~~~
> - Ingo Molnar put a lot of work into threading improvements for 2.6.
>   Some of the features of this work are:
>   -  Generic pid allocator (arbitrary number of PIDs with no slowdown,
>      unified pidhash).
>   -  Thread Local Storage syscalls
>   -  sys_clone() enhancements (CLONE_SETTLS, CLONE_PARENT_SETTID,
> CLONE_SETTID, CLONE_CLEARTID, CLONE_DETACHED)
>   -  POSIX thread signals stuff (atomic signals, shared signals, etc.)
>   -  Per-CPU GDT
>   -  Threaded coredumping support
>   -  sys_exit() speedups (O(1) exit)
>   -  Generic, improved futexes, vcache

vcache is gone. futex pages are swappable now and not pinned anymore.

Good work. I love this document ;-)

Regards

Ingo Oeser


