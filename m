Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSFUSwa>; Fri, 21 Jun 2002 14:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSFUSwa>; Fri, 21 Jun 2002 14:52:30 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:61944 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316751AbSFUSw3>; Fri, 21 Jun 2002 14:52:29 -0400
Date: Fri, 21 Jun 2002 14:52:30 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Robert Love <rml@tech9.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] (resend) credentials for 2.5.23
Message-ID: <20020621145230.B1499@redhat.com>
References: <20020619212909.A3468@redhat.com> <1024540235.917.127.camel@sinai> <20020620122858.B4674@redhat.com> <1024593066.922.149.camel@sinai> <shs4rfwx4uc.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs4rfwx4uc.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Fri, Jun 21, 2002 at 01:12:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 01:12:59PM +0200, Trond Myklebust wrote:
>   Making the credentials a monolithic block like you appear to be
> doing just doesn't make sense. If you look at the way things like
> fsuid/fsgid/groups[] are used, you will see that almost all those that
> filesystems that care are making their own private copies.

I'm not looking at things from the filesystem's point of view, so 
much as for threads and aio, where rlimits and identificantion needs 
to be shared between contexts.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
