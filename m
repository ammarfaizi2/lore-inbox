Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVLSEbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVLSEbi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLSEbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:31:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:1484 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030251AbVLSEbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:31:37 -0500
Date: Mon, 19 Dec 2005 05:31:36 +0100
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219043136.GI23384@wotan.suse.de>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.58.0512182327280.3446@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512182327280.3446@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps it's the smaller structures, as Ingo said, which would allow for
> better cache handling.

That still doesn't seem credible on a large cached x86 CPU.
However if it's that then oprofile could tell I guess.

-Andi
