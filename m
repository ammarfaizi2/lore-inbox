Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTEOCGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTEOCGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:06:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:1408 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263675AbTEOCGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:06:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 14 May 2003 19:18:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Christopher Hoover <ch@murgatroid.com>
cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <002901c31a86$0f606020$175e040f@bergamot>
Message-ID: <Pine.LNX.4.55.0305141917260.4539@bigblue.dev.mcafeelabs.com>
References: <002901c31a86$0f606020$175e040f@bergamot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Christopher Hoover wrote:

>
> > This should also break kernels with MMUs ( see mm_release ).
>
> I don't believe it does as there's a cond_syscall entry for sys_futex.

Yep, you're right cond_syscall does it.



- Davide

