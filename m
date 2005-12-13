Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVLMPXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVLMPXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVLMPXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:23:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8344 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964999AbVLMPXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:23:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1134482408.11732.30.camel@localhost.localdomain> 
References: <1134482408.11732.30.camel@localhost.localdomain>  <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 15:23:34 +0000
Message-ID: <14796.1134487414@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Is there a reason you didnt answer the comment about down/up being the
> usual way computing refers to the operations on counting semaphores but
> just deleted it ?

up/down is also used in conjunction with mutexes and R/W semaphores, so
counting semaphores do not have exclusive rights to the terminology.

David
