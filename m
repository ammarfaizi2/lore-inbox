Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVA0Ivw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVA0Ivw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 03:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVA0Ivw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 03:51:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25283 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262527AbVA0Ivu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 03:51:50 -0500
Date: Thu, 27 Jan 2005 09:51:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Cal <hihone@bigpond.net.au>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, Mike Galbraith <efault@gmx.de>
Subject: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D8
Message-ID: <20050127085120.GF22482@elte.hu>
References: <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au> <20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au> <87acqwnnx1.fsf@sulphur.joq.us> <41F7DA1B.5060806@bigpond.net.au> <87vf9km31j.fsf@sulphur.joq.us> <41F84BDF.3000506@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F84BDF.3000506@bigpond.net.au>
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


* Cal <hihone@bigpond.net.au> wrote:

> Sorry for the delay, some sleep required. A build without SMP also 
> fails, with multiple oops.
>   <http://www.graggrag.com/200501271213-oops/>.

thanks, this pinpointed the bug - i've uploaded the -D8 patch to the
usual place:

  http://redhat.com/~mingo/rt-limit-patches/

does it fix your crash? Mike Galbraith reported a crash too that i think
could be the same one.

	Ingo
