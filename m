Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUIVOFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUIVOFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUIVOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:05:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:55685 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265395AbUIVOFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:05:14 -0400
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <m37jqmeby9.fsf@averell.firstfloor.org>
References: <2GFBZ-61e-11@gated-at.bofh.it> <2GSfS-6eW-5@gated-at.bofh.it>
	 <2H0ZO-49v-13@gated-at.bofh.it> <2HdDL-48z-53@gated-at.bofh.it>
	 <2HdNp-4eJ-27@gated-at.bofh.it>  <m37jqmeby9.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1095861889.17821.1337.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 22 Sep 2004 15:04:50 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 14:15 +0200, Andi Kleen wrote:
> > Ever heard of iptables?
> 
> Except that it doesn't have usable 32bit emulation on x86-64.
> 32bit userland on x86-64 kernel cannot use iptables, they have
> to use ipchains.
> 
> I would ask for to not drop ipchains until this is fixed.

Agreed. The iptables compatibility with 32-bit userspace is completely
broken.

-- 
dwmw2

