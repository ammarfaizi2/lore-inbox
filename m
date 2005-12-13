Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVLMJOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVLMJOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLMJOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:14:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20919 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932576AbVLMJOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:14:14 -0500
Date: Tue, 13 Dec 2005 10:13:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, dhowells@redhat.com, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213091328.GG10088@elte.hu>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213090429.GC27857@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090429.GC27857@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > 
> > Remove -Wdeclaration-after-statement
> > 
> > Now that gcc 2.95 is not supported anymore it's ok to use C99
> > style mixed declarations everywhere.
> 
> Nack.  This code style is pure obsfucation and we should disallow it 
> forever.

agreed. I often get quilt mismerges uncovered by that warning. If 
someone wants to start a new section of code that is too large, it 
should go into a separate function.

	Ingo
