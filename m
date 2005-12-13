Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVLMOAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVLMOAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLMOAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:00:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7836 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932315AbVLMOAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:00:30 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <3874.1134480759@warthog.cambridge.redhat.com>
References: <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 14:00:08 +0000
Message-Id: <1134482408.11732.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 13:32 +0000, David Howells wrote:
> > Its then obvious what it does, you don't randomly break other drivers you've
> > not reviewed and the interface is intuitive rather than obfuscated.
> 
> I've attempted to review everything in 2.6.15-rc5 outside of most of the archs.
> I can't easily modify any driver not contained in that tarball, but at least
> the compiler will barf and force a review.


Is there a reason you didnt answer the comment about down/up being the
usual way computing refers to the operations on counting semaphores but
just deleted it ?

