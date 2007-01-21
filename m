Return-Path: <linux-kernel-owner+w=401wt.eu-S1751524AbXAUMpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbXAUMpW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 07:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXAUMpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 07:45:22 -0500
Received: from av5.karneval.cz ([81.27.192.12]:9047 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751510AbXAUMpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 07:45:22 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Realtime-preemption for 2.6.20-rc5 ?
Date: Sun, 21 Jan 2007 13:44:05 +0100
User-Agent: KMail/1.9.4
Cc: Sunil Naidu <akula2.shark@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200701210039.27284.pisa@cmp.felk.cvut.cz> <1169370638.6197.175.camel@twins>
In-Reply-To: <1169370638.6197.175.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701211344.05853.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 January 2007 10:10, Peter Zijlstra wrote:
> > I preffer
> > to stay on "stable" kernel on boxes which I use daily until next stable
> > appears.
>
> This is a very weird statement, the -rt kernel includes so much
> experimental work it cannot be called 'stable' by a long shot.
>
> Sure its not known unstable, but neither is .20-rc5.

There are no security fixes for rc and our own experience
is, that RT patch has very low impact on base system stability.
The rc-s contains much more experimental stuff all over the
kernel which needs to be stabilized till next (hopefully) stable
release.

> If you want -rt, just run with the latest unless you have a very
> specific need not to.

We have run successfully 2.6.16.1-rt12 over last summer
semester on students diskless stations without much problems.
(Main problem has been some NFS FS problem with 1GB/s server, 100MB/s
stations and switches in between, but it has been same for non-RT kernel.
We solved that by switching NFS over TCP.)

We would like to upgrade to something which would not cause us much
troubles for next course run. We teach real time control in X35POS
course and we need fast responses and timing (100 usec) for direct
PWM and IO control.

On the other hand, I agree that for own experimentation and development
it is better to build on latest released version.

Best wishes

             Pavel
