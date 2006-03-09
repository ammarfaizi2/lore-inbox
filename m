Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWCIAzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWCIAzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWCIAzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:55:23 -0500
Received: from ozlabs.org ([203.10.76.45]:8095 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932681AbWCIAzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:55:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.30924.278031.151438@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 11:37:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <20060308194037.GO7301@parisc-linux.org>
References: <20060308184500.GA17716@devserv.devel.redhat.com>
	<20060308173605.GB13063@devserv.devel.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<9834.1141837491@warthog.cambridge.redhat.com>
	<11922.1141842907@warthog.cambridge.redhat.com>
	<14275.1141844922@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<20060308194037.GO7301@parisc-linux.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:

> Looking at the SGI implementation, it's smarter than you think.  Looks
> like there's a register in the local I/O hub that lets you determine
> when this write has been queued in the appropriate host->pci bridge.

Given that mmiowb takes no arguments, how does it know which is the
appropriate PCI host bridge?

Paul.
