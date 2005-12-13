Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVLMJJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVLMJJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVLMJJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:09:20 -0500
Received: from ns.suse.de ([195.135.220.2]:4487 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964831AbVLMJJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:09:18 -0500
Date: Tue, 13 Dec 2005 10:09:17 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090917.GC15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <1134460804.2866.17.camel@laptopd505.fenrus.org> <20051213090349.GE10088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090349.GE10088@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it's not _that_ bad, if done overnight. It does not touch any of the 
> down/up APIs. Touching those would create a monster patch and monster 
> impact.

One argument for a full rename (and abandoning the old "struct semaphore"
name completely) would be that it would offer a clean break for out tree code,
no silent breakage. 

-Andi

