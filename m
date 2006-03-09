Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWCIBIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWCIBIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCIBIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:08:49 -0500
Received: from ozlabs.org ([203.10.76.45]:39844 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751233AbWCIBIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:08:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.32792.500628.226831@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 12:08:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<20060308184500.GA17716@devserv.devel.redhat.com>
	<20060308173605.GB13063@devserv.devel.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<9834.1141837491@warthog.cambridge.redhat.com>
	<11922.1141842907@warthog.cambridge.redhat.com>
	<14275.1141844922@warthog.cambridge.redhat.com>
	<19984.1141846302@warthog.cambridge.redhat.com>
	<17423.30789.214209.462657@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> > If you ask me, the need for mmiowb on some platforms merely shows that
> > those platforms' implementations of spinlocks and read*/write* are
> > buggy...
> 
> You could also state that same as
> 
> 	"If you ask me, the need for mmiowb on some platforms merely shows 
> 	 that those platforms perform like a bat out of hell, and I think 
> 	 they should be slower"
> 
> because the fact is, x86 memory barrier rules are just about optimal for 
> performance.

... and x86 mmiowb is a no-op.  It's not x86 that I think is buggy.

Paul.
