Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVLMLZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVLMLZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 06:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVLMLZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 06:25:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750795AbVLMLZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 06:25:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051213105459.GA9879@elte.hu> 
References: <20051213105459.GA9879@elte.hu>  <dhowells1134431145@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 13 Dec 2005 11:24:45 +0000
Message-ID: <1036.1134473085@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> >      	init_MUTEX_LOCKED()
> > 	DECLARE_MUTEX_LOCKED()
> 
> please kill these two in the simple mutex implementation - they are a 
> sign of mutexes used as completions.

That can be done later. It's not necessary to do it in this particular patch
set.

David
