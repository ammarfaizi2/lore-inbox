Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUHORdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUHORdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHORdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:33:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7627 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266199AbUHORc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:32:58 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1092578502.6543.4.camel@twins>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu>  <20040815115649.GA26259@elte.hu>
	 <1092578502.6543.4.camel@twins>
Content-Type: text/plain
Message-Id: <1092591223.1118.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 13:33:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 10:01, Peter Zijlstra wrote:

> It still locks up hard for me when voluntary-preempt=3, however it does
> finish the boot; dmesg attached. The lockup occurs several minutes into
> use; usually by by the time I've started X, launched evolution and
> selected my first imap folder the machine's dead.
> 
> If you need more information or want me to try some patches, just let me
> know.

These look a bit worrisome:

Aug 15 15:24:11 twins kernel: Total of 2 processors activated (5537.79 BogoMIPS).
Aug 15 15:24:11 twins kernel: WARNING: This combination of AMD processors is not suitable for SMP.
Aug 15 15:24:11 twins kernel: ENABLING IO-APIC IRQs

Aug 15 15:24:11 twins kernel: I/O APIC: AMD Errata #22 may be present. In the event of instability try
Aug 15 15:24:11 twins kernel:         : booting with the "noapic" option.

Lee



