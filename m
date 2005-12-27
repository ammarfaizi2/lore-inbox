Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVL0RlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVL0RlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVL0RlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:41:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:22154 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751131AbVL0RlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:41:17 -0500
Message-ID: <6904406.1135705241311.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Tue, 27 Dec 2005 18:40:41 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 04/11] mutex subsystem, add include/asm-x86_64/mutex.h
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <43B158A6.7080508@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <20051227141548.GE6660@elte.hu> <43B158A6.7080508@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di 27.12.2005 16:07 schrieb Eric Dumazet <dada1@cosmosbay.com>:

> Or call a wrapper that does the PUSH/POP thing.

Standard wrappers for this are in arch/x86_64/lib/thunk.S

-Andi (who always wished gcc had an function __attribute__ for this)


