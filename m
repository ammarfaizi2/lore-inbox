Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUJPTte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUJPTte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUJPTtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:49:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:64689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268802AbUJPTru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:47:50 -0400
Date: Sat, 16 Oct 2004 12:45:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: roland@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] JVM crashes with 2.6.9-rc2
Message-Id: <20041016124519.627456de.akpm@osdl.org>
In-Reply-To: <1097928466.13431.8.camel@localhost>
References: <1097928466.13431.8.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> Hi,
> 
> Sun JVM 1.4.2_06 crashes with Linux 2.6.9-rc2 and later on i386 when I
> start Eclipse. The JVM dies a horrible death claiming internal error.  I
> noticed similar problem with Blackdown JDK 1.4.2_rc1 as well.  I have
> put a full strace of the run here [1].

Could you test
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/old/patch-2.6.9-rc4-bk3.gz?


> I also tested 2.6.7, 2.6.8.1, and 2.6.9-rc1 and they all work fine.
> Reverting Roland's i386 syscall tracing patch [2] from 2.6.9-rc2 makes
> the problem go away for me.

That's peculiar.  Are you sure about that?

> 
>   1. http://www.cs.helsinki.fi/u/penberg/linux/eclipse-strace
>   2. http://linus.bkbits.net:8080/linux-2.5/cset@1.1832.54.195

