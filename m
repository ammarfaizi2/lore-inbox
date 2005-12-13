Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVLMXmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVLMXmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVLMXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:42:00 -0500
Received: from ns2.suse.de ([195.135.220.15]:10923 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030317AbVLMXl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:41:59 -0500
Date: Wed, 14 Dec 2005 00:41:33 +0100
From: Andi Kleen <ak@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, rth@redhat.com
Subject: Re: Using C99 in the kernel was Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213234133.GZ23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <Pine.LNX.4.64.0512130812020.15597@g5.osdl.org> <20051213215610.GX23384@wotan.suse.de> <20051213230536.GQ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213230536.GQ27946@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are two similar things - struct initializers and compound literals.

I know they are not the same, but it's still annoying that gcc arbitarily
changes the definition of "GNU C" again. That is why I would consider
it more a bug than a feature. 

-Andi
