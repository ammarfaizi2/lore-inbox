Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269447AbUJFU1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269447AbUJFU1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUJFUH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:07:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:14790 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269447AbUJFUGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:06:13 -0400
Date: Wed, 6 Oct 2004 22:07:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041006200737.GC15003@elte.hu>
References: <OF57A902F3.999F14FA-ON86256F25.006D1FB5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF57A902F3.999F14FA-ON86256F25.006D1FB5@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >Meanwhile, I'm stuck with 2.6.9-rc2-mm4-S7 (SMP), but happy.
> >
> >Strange thing is, that on my laptop, 2.6.9-rc3-mm2-S9 (UP) is doing just
> >fine. Guess that ohci_hcd now makes the difference here, against the
> >former which makes uhci_hcd bad behaved atm.
> 
> I am having similar problems with -T1 and separately reported problems
> with a build of rc3-mm1-S8 as well (no oops, but the USB mouse is
> dead). Somewhere between those two versions (rc2-mm4-S7 and
> rc3-mm1-S8) is where the problem appears to be introduced. For now
> I'll stay with my working -S0 kernel.

disable USB for now - it's broken in -mm and unrelated to -VP. There are
hopes that in -rc3-mm3 USB will work again.

	Ingo
