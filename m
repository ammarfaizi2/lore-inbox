Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269908AbUJHNC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269908AbUJHNC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUJHNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:02:58 -0400
Received: from ozlabs.org ([203.10.76.45]:29409 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269908AbUJHNC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:02:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16742.36752.461737.252196@cargo.ozlabs.ibm.com>
Date: Fri, 8 Oct 2004 23:01:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Replace cmp instructions with cmpw/cmpd
In-Reply-To: <1097228724.318.65.camel@hades.cambridge.redhat.com>
References: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
	<1097228724.318.65.camel@hades.cambridge.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> On Fri, 2004-10-08 at 15:37 +1000, Paul Mackerras wrote:
> > This patch replaces cmp{,l}{,i} with cmp{,l}[wd]{,i} as appropriate.
> > The original patch was from Segher Boessenkool, slightly modified by
> > me.  Please apply.
> 
> And also for ppc32 and arch/ppc64/kernel/ItLpQueue.c...

Looks fine to me.  Andrew/Linus, please apply.  Or, if David resends
with a signed-off-by, I'll add mine and send it on. :)

Paul.
