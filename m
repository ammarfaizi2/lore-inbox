Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVBIS4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVBIS4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBIS4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:56:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:22673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbVBIS4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:56:30 -0500
Date: Wed, 9 Feb 2005 10:56:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davem@redhat.com, chrisw@osdl.org
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-ID: <20050209105622.Z24171@build.pdx.osdl.net>
References: <20050209093927.GA9726@elte.hu> <20050210020333.7941fa6e.sfr@canb.auug.org.au> <20050209180219.GC23554@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050209180219.GC23554@elte.hu>; from mingo@elte.hu on Wed, Feb 09, 2005 at 07:02:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> this patch does the final consolidation of asm-*/resource.h file,
> without changing any of the rlimit definitions on any architecture.
> Primarily it removes the __ARCH_RLIMIT_ORDER method and replaces it with
> a more compact and isolated one that allows architectures to define only
> the offending rlimits.

Heh, I did it this way first, then worried people might find it confusing
to only have a subset of the block overwritten I backed it down to
the __ARCH_RLIMIT_ORDER method.  Anyway, I like this change.

Acked-by: Chris Wright <chrisw@osdl.org>

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
