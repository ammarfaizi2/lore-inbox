Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163257AbWLGUFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163257AbWLGUFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163255AbWLGUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:05:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58217 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163253AbWLGUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:05:44 -0500
Date: Thu, 7 Dec 2006 21:04:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061207200403.GA10479@elte.hu>
References: <20061205171114.GA25926@elte.hu> <4577FC21.1080407@cybsft.com> <20061207121344.GA19749@elte.hu> <4578391E.40001@cybsft.com> <20061207165751.GA2720@elte.hu> <45786E32.3010201@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45786E32.3010201@cybsft.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> > ah, indeed. I went for a slightly different approach - see the patch 
> > below. Sending an NMI to all CPUs is not something that is tied to 
> > KEXEC, it belongs into nmi.c.
> > 
> > 	Ingo
> 
> Much better I think. It still requires the patch below, which includes 
> mach_ipi.h, to build here.

yeah, and an #ifdef CONFIG_SMP to build on UP :-/

	Ingo
