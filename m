Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWJCKyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWJCKyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWJCKyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:54:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:62893 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030290AbWJCKyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:54:44 -0400
Date: Tue, 3 Oct 2006 11:54:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: David Miller <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: linux/compat.h includes asm/signal.h causing problems
Message-ID: <20061003105435.GG29920@ftp.linux.org.uk>
References: <20061002.141850.18280315.davem@davemloft.net> <20061002.131414.74728780.davem@davemloft.net> <20061002135036.7bd1f76b.akpm@osdl.org> <20061002.140437.78732307.davem@davemloft.net> <9802.1159868725@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9802.1159868725@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:45:25AM +0100, David Howells wrote:
> David Miller <davem@davemloft.net> wrote:
> 
> > > I'm working on a patch that puts the compat signal bits into
> > > include/asm-sparc64/compat_signal.h and adds the necessary
> > > includes to a few *.c files under arch/sparc64 when needed.
> > 
> > Ok, this seems to work and is what I'll sent to Linus.
> 
> Do you have an x86-hosted or an x86_64-hosted cross-compiler that targets
> sparc/sparc64?

I do, it's not a problem...
