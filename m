Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWIMQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIMQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIMQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:58:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36526 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750768AbWIMQ6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:58:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060913163806.GA15563@flint.arm.linux.org.uk> 
References: <20060913163806.GA15563@flint.arm.linux.org.uk>  <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com> <20060913161734.GE3564@stusta.de> <20060913163136.GA2585@parisc-linux.org> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 13 Sep 2006 17:56:55 +0100
Message-ID: <4143.1158166615@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Therefore, re-using "log2()" is about as bad as re-using the "strcmp()"
> name to implement a function which copies strings.

I should probably use ilog2() then which would at least be consistent with the
powerpc arch.

> t.c:2: warning: conflicting types for built-in function 'log2'

Which, of course, I didn't see because I didn't define it as a function,
merely as a macro.

David
