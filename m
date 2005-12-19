Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVLSEag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVLSEag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLSEag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:30:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:62155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030254AbVLSEaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:30:35 -0500
Date: Mon, 19 Dec 2005 05:30:32 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 09/15] Generic Mutex Subsystem, mutex-migration-helper-x86_64.patch
Message-ID: <20051219043032.GH23384@wotan.suse.de>
References: <20051219013827.GE28038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219013827.GE28038@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 02:38:27AM +0100, Ingo Molnar wrote:
> 
> introduce the arch_semaphore type on x86_64, to ease migration to 
> mutexes.

As a small feedback I don't think the name arch_semaphore
is very good because it means nothing.  How about counting_semaphore 
which is what it actually is? 

-Andi

