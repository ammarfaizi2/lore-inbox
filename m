Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKAJ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKAJ6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 04:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVKAJ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 04:58:36 -0500
Received: from ozlabs.org ([203.10.76.45]:24729 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750716AbVKAJ6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 04:58:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17255.15408.824123.131620@cargo.ozlabs.ibm.com>
Date: Tue, 1 Nov 2005 20:58:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
In-Reply-To: <20051101051221.GA26017@lst.de>
References: <20051101050900.GA25793@lst.de>
	<20051101051221.GA26017@lst.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> > Some architectures have a too different ptrace so we have to exclude
> > them.  They continue to keep their implementations.  For sh64 I had to
> > add a sh64_ptrace wrapper because it does some initialization on the
> > first call.  For um I removed an ifdefed SUBARCH_PTRACE_SPECIAL block,
> > but SUBARCH_PTRACE_SPECIAL isn't defined anywhere in the tree.
> 
> Umm, it might be a good idea to actually send the current patch instead
> of the old one.  I really should write this text from scratch instead
> of copying it :)
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Mackerras <paulus@samba.org>
