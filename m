Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbUKDG4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbUKDG4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUKDG4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:56:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:34467 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262119AbUKDGzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:55:04 -0500
Date: Thu, 4 Nov 2004 07:56:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Magnus Naeslund(t)" <mag@fbab.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104065604.GA15830@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <418963BD.5030303@fbab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418963BD.5030303@fbab.net>
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


* Magnus Naeslund(t) <mag@fbab.net> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.1 Real-Time Preemption patch, which can be
> >downloaded from:
> >
> >    http://redhat.com/~mingo/realtime-preempt/
> >
> >this release is mainly a merge of -V0.6.9 to 2.6.10-rc2-mm2.
> >
> [snip]
> 
> I just wanted to tell you that my network problems with the e100
> driver disappeared. I still get the BUG in enable_irq, but now the
> network works. I dunno if this is due to 2.6.10-rc2-mm2 fixes or your
> own fixes, but i'm now happy :)

while doing the merge i noticed and removed an older hack i added to the
e100 driver (and the rtl8139 driver) - possibly this could be related.

	Ingo
