Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVLSQk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVLSQk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVLSQk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:40:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33003 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964843AbVLSQk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:40:26 -0500
Date: Mon, 19 Dec 2005 17:39:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051219163940.GF8160@elte.hu>
References: <20051219013837.GF28038@elte.hu> <1135001786.13138.249.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135001786.13138.249.camel@localhost.localdomain>
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

> > +       DEBUG_WARN_ON(val != 0 && val != 1);
> 
> DEBUG_WARN_ON in this part of the #if is always a no-op.

ok, zapped it.

	Ingo
