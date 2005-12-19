Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVLSOh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVLSOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLSOh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:37:29 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:13010 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932099AbVLSOh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:37:28 -0500
Subject: Re: [patch 15/15] Generic Mutex Subsystem, arch-semaphores.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219014043.GK28038@elte.hu>
References: <20051219014043.GK28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:36:52 -0500
Message-Id: <1135003012.13138.261.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:40 +0100, Ingo Molnar wrote:
> mark all semaphores that are known to be used in a non-mutex fashion,
> as 
> arch_semaphores. This has relevance for the CONFIG_DEBUG_MUTEX_FULL 
> debugging kernel: these semaphores will never be changed to mutexes,
> not 
> even for debugging purposes.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

OK, I've finished going through each patch, and gave my comments as I
saw them.  When I get more time, I'll actually apply them and try them
out.

-- Steve

Acked-by: Steven Rostedt <rostedt@goodmis.org>


