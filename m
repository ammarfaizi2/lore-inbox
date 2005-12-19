Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVLSFQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVLSFQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 00:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVLSFQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 00:16:54 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:58014 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030266AbVLSFQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 00:16:54 -0500
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013718.GA28038@elte.hu>
References: <20051219013718.GA28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 00:16:12 -0500
Message-Id: <1134969372.13138.243.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> mutex implementation, core files: just the basic subsystem, no users
> of it.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ----
> 
>  include/linux/mutex.h   |  102 ++++++++
>  include/linux/preempt.h |    1 
>  include/linux/sched.h   |    5 
>  kernel/Makefile         |    2 
>  kernel/fork.c           |    4 
>  kernel/mutex.c          |  564
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 677 insertions(+), 1 deletion(-)
> 

OK, I went through patches 1-5 with a fine tooth comb.   Time for bed.
I'll do the rest tomorrow (oh wait, damn that's today!)

Patches 1-5:
Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


