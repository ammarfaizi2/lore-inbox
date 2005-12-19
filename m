Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVLSEWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVLSEWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVLSEWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:22:04 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13546 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030246AbVLSEWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:22:03 -0500
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
Date: Sun, 18 Dec 2005 23:21:40 -0500
Message-Id: <1134966100.13138.224.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> +#ifdef CONFIG_DEBUG_MUTEXESS
> +# include "mutex-debug.c"
> +#else /* !CONFIG_DEBUG_MUTEXESS */
> +

Note: patch 05 is dependent on patch 06.  Well, if you want debugging.

-- Steve


