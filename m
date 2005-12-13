Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVLMJzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVLMJzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVLMJzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:55:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750811AbVLMJzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:55:10 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439E122E.3080902@yahoo.com.au> 
References: <439E122E.3080902@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 09:54:49 +0000
Message-ID: <22479.1134467689@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> We have atomic_cmpxchg. Can you use that for a sufficient generic
> implementation?

No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.

David
