Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUJLGFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUJLGFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUJLGFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:05:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17088 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269472AbUJLGC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:02:59 -0400
Date: Tue, 12 Oct 2004 08:02:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012060213.GD1479@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <416B54BA.9050606@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416B54BA.9050606@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >i've uploaded -T5 which should fix most of the build issues:
> >
> 
> This fixed the build problems for me (SMP). I did get one unresolved
> symbol when building this with REALTIME enabled.

(which symbol was this?)

> [...] Also got error messages scrolling up the screen when I tried to
> boot it (looked very much like Mark's problem with T4) and it never
> made it. :( If I had to guess, it might be related to APICs? I always
> have to use "noapic" boot parameter.  Ingo what are you running this
> on? I don't have the exact error messages, but I'm rebuilding it now
> to try to get those. Without RT Preemption it seems to be running very
> nicely.

dont worry about it not booting on your setup with PREEMPT_REALTIME, as
long as it boots with !PREEMPT_REALTIME - i only really converted my
testsystems which are basically IDE + e100/e1000/rtl8139, ext3 and the
bare minimum that is needed to run Fedora. It might be useful to send me
a bootlog if you have any easy way to capture it - if not it's not a big
problem either.

	Ingo
