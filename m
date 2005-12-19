Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVLSRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVLSRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVLSRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:01:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22429 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964860AbVLSRBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:01:07 -0500
Date: Mon, 19 Dec 2005 18:00:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 07/15] Generic Mutex Subsystem, mutex-debug-more.patch
Message-ID: <20051219170026.GD8635@elte.hu>
References: <20051219013807.GC28038@elte.hu> <1135000829.13138.245.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135000829.13138.245.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The changes here from smp_processor_id to raw_smp_processor_id seem to 
> be more clean up and not part of the mutex patch.  Should these be 
> sent separately?

yeah, that's a bugfix for spinlock debugging, which should go in before 
2.6.15 is released. Andrew/Linus, please apply.

	Ingo
