Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUG1GJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUG1GJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUG1GJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:09:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26082 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266114AbUG1GJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:09:14 -0400
Date: Wed, 28 Jul 2004 06:59:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Message-ID: <20040728045916.GA14474@elte.hu>
References: <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu> <1090969026.743.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090969026.743.12.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> The obvious next feature to add would be to make certain IRQs
> non-schedulable, like you would for an RT system.  For an audio system
> this would be just the soundcard interrupt (and timer as stated
> above).  Then, while it still might not be hard-RT, it would blow away
> anything achievable on the other OS'es people do audio work with.

yes, this is the next step. Does v=3 work on your system? (even if the
delaying of the soundcard irq causes latencies.)

	Ingo
