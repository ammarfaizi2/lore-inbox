Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266902AbUG1W6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUG1W6u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUG1Wzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:55:45 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26372 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266194AbUG1Wza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:55:30 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Cc: "Saksena, Manas" <Manas.Saksena@timesys.com>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Wood, Scott" <Scott.Wood@timesys.com>
In-Reply-To: <200407282259.20577.cr7@os.inf.tu-dresden.de>
References: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
	 <200407282259.20577.cr7@os.inf.tu-dresden.de>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 00:55:11 +0200
Message-Id: <1091055311.1844.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 22:59 +0200, Carsten Rietzschel wrote:

> It might be interesting for you to test it with suspend(1) / pm_disk (sorry, 
> these don't work for me). I wonder if they'll also fail.

For me, swsusp1/pmdisk works nicely with 0 <= voluntary_preempt <= 3,
even with CONFIG_PREEMPT.

