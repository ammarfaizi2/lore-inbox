Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUHXGP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUHXGP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUHXGP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:15:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7080 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267399AbUHXGNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:13:53 -0400
Date: Tue, 24 Aug 2004 08:14:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: manas.saksena@timesys.com, linux-kernel@vger.kernel.org
Subject: [patch] voluntary-preempt-2.6.8.1-P9
Message-ID: <20040824061459.GA29630@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823221816.GA31671@yoda.timesys>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Scott Wood <scott@timesys.com> wrote:

> I have attached a port of the voluntary preempt patch to PPC and
> PPC64.  The patch is against P7, but it applies against P8 as well.

thanks Scott, i've applied your patch to my tree - all the changes and
improvements look good (except for a small compilation problem on x86,
asm/time.h doesnt exist there - asm/rtc.h does). The resulting code
booted fine on an SMP and on a UP x86 system. I've uploaded -P9:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9

(there are no other changes in -P9.)

	Ingo
