Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVLVQgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVLVQgu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVLVQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:36:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:21860 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965166AbVLVQgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:36:50 -0500
Date: Thu, 22 Dec 2005 11:36:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-reply-to: <20051222153717.GA6090@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222153717.GA6090@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> Changes since -V4:
> 
> - removed __ARCH_WANT_XCHG_BASED_ATOMICS and implemented
>   CONFIG_MUTEX_XCHG_ALGORITHM instead, based on comments from
>   Christoph Hellwig.
> 
> - updated ARM to use CONFIG_MUTEX_XCHG_ALGORITHM.

This is still not what I'd like to see, per my previous comments.

Do you have any strong reason for pursuing that route instead of going 
with my suggested approach?


Nicolas
