Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUHBGWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUHBGWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHBGWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:22:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:50692 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266303AbUHBGWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:22:13 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Daniel Schmitt <pnambic@unu.nu>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <200408020120.55127.pnambic@unu.nu>
References: <20040713143947.GG21066@holomorphy.com>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <200408020120.55127.pnambic@unu.nu>
Content-Type: text/plain
Date: Mon, 02 Aug 2004 08:21:55 +0200
Message-Id: <1091427715.1827.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 01:20 +0200, Daniel Schmitt wrote:
> On Sunday 01 August 2004 21:30, Ingo Molnar wrote:
> > here's the latest version of the voluntary-preempt patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2
> 
> One minor problem: this crashes hard (in interrupt context, stack pointer is 
> bogus) during early boot iff CONFIG_REGPARM is set. With the earlier patches, 
> this didn't happen. No ill effects so far with the default ABI; performance 
> (apart from the usual reiserfs problems) is flawless.

Hmmm... I have CONFIG_REGPARM enabled and it didn't crash for me at all.

