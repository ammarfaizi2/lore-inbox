Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCCAxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCCAxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVCCAtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:49:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:5765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbVCCAs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:48:56 -0500
Date: Wed, 2 Mar 2005 16:48:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302164847.294e7bca.akpm@osdl.org>
In-Reply-To: <16934.22078.129692.140147@cse.unsw.edu.au>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<16934.22078.129692.140147@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
> But more recently I have discovered that quite a few key developers
> develop against Linus' kernel and submit patches directly to him,
> apparently bypassing Andrew.  This leads to them holding back patches
> when a release is approaching, rather than sending them straight to
> Andrew for -mm and wider testing.  This doesn't sound like a good
> thing.
> 

Only davem, AFAIK.  All the other trees get auto-sucked into -mm for
testing.  Generally the owners of those trees make the decision as to which
of their code has been sufficiently well-tested for a Linus merge, and when
that should happen.

> Now, I know our movement is all about freedom (and openness), and you
> don't want to force developers into any behaviour patterns that aren't
> essential, but I think it would be nice if there was some uniform
> perspective on how patches should flow so that we all understood what
> each other were doing.
> 
> My own preference would be:
>   - all patches go to Andrew and appear in -mm promptly
>   - Linus only gets patches from -mm
>      - most patches are only passed to Linus after they have
>        been in an -mm release for at least ....   1 week (?)
>      - some patches go straight to Linus even before a -mm
>        release if maintainer + Andrew + Linus review and agree
>      - some patches stay in -mm for extended periods getting refined
>        before making their way to Linus.
>      - some patches get ditched from -mm and never make it to Linus.

That's basically what happens now, except I don't physically send the
patches from those 32 bk trees to Linus.

