Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTEOBbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTEOBbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:31:06 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47520 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263441AbTEOBbF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:31:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 14 May 2003 18:42:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linus Torvalds <torvalds@transmeta.com>, ch@murgatroid.com,
       inaky.perez-gonzalez@intel.com, hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <20030514183925.67a538fc.akpm@digeo.com>
Message-ID: <Pine.LNX.4.55.0305141841400.4539@bigblue.dev.mcafeelabs.com>
References: <20030514182526.36823e2b.akpm@digeo.com>
 <Pine.LNX.4.44.0305141827200.28093-100000@home.transmeta.com>
 <20030514183925.67a538fc.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Morton wrote:

> +menu "Size reduced kernel"
> +
> +config FUTEX
> +	bool "Futex support"
> +	default y
> +	---help---
> +	Say Y if you want support for Fast Userspace Mutexes (Futexes).
> +	WARNING: disabling futex support will probably cause glibc to fail.

This should also break kernels with MMUs ( see mm_release ).



- Davide

