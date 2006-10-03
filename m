Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWJCKcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWJCKcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWJCKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:32:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10945 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030220AbWJCKcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:32:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <10243.1159869674@warthog.cambridge.redhat.com> 
References: <10243.1159869674@warthog.cambridge.redhat.com>  <20061002201836.GB31365@elte.hu> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org> 
To: David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 03 Oct 2006 11:30:04 +0100
Message-ID: <10922.1159871404@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> I wish.  No, it's not simple enough to script.  All the usages of struct
> pt_regs have to be eyeballed and have to be poked with the compiler.  The
> problem is when an interrupt handler passes regs down to someone else - that I
> can't find.

Can't find with grep, I mean.

David
