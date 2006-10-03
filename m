Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWJCJpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWJCJpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWJCJpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:45:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18593 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964841AbWJCJpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:45:43 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061002.141850.18280315.davem@davemloft.net> 
References: <20061002.141850.18280315.davem@davemloft.net>  <20061002.131414.74728780.davem@davemloft.net> <20061002135036.7bd1f76b.akpm@osdl.org> <20061002.140437.78732307.davem@davemloft.net> 
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       axboe@suse.de
Subject: Re: linux/compat.h includes asm/signal.h causing problems 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 03 Oct 2006 10:45:25 +0100
Message-ID: <9802.1159868725@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> > I'm working on a patch that puts the compat signal bits into
> > include/asm-sparc64/compat_signal.h and adds the necessary
> > includes to a few *.c files under arch/sparc64 when needed.
> 
> Ok, this seems to work and is what I'll sent to Linus.

Do you have an x86-hosted or an x86_64-hosted cross-compiler that targets
sparc/sparc64?

David
