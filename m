Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSFQVMb>; Mon, 17 Jun 2002 17:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSFQVMa>; Mon, 17 Jun 2002 17:12:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55536 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317018AbSFQVM3>; Mon, 17 Jun 2002 17:12:29 -0400
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
From: Robert Love <rml@tech9.net>
To: Bob Miller <rem@osdl.org>
Cc: Dave Jones <davej@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020617135744.A24347@doc.pdx.osdl.net>
References: <20020617161434.D1457@redhat.com> <20020617222812.I758@suse.de>
	 <20020617135744.A24347@doc.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 14:12:20 -0700
Message-Id: <1024348340.922.124.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-17 at 13:57, Bob Miller wrote:

> It depends on what you mean by killed off.  I submitted a patch to Linus back
> at 2.5.3 to clean up the way the completion code called the wait queue
> interface.  This interface got added then.  You picked up those changes at
> that time (and still have them in your kernel tree) but the changes have
> never made it into Linus' tree.
> 
> So, Linus has never had the code to 'kill' and you've never dropped it
> after picking it up.

Work has gone in since this.

During 2.5.20, Linus asked for and I submitted a patch to remove the
whole wq_lock_t mess altogether.  It was merged into 2.5.21. 
Subsequently, there is no wq_lock_t abstraction in current 2.5 kernels
and code should use a standard spinlock.

	Robert Love

