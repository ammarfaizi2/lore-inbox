Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUJGV5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUJGV5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUJGV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:56:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48512 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269673AbUJGVye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:54:34 -0400
Date: Thu, 7 Oct 2004 23:55:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041007215546.GA8541@elte.hu>
References: <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <4165832E.1010401@cybsft.com> <4165A729.5060402@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4165A729.5060402@cybsft.com>
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

> >For me, this one wants to panic on boot when trying to find the root 
> >filesystem. Acts like either the aic7xxx module is missing (which I 
> >don't think is the case) or hosed, or it's having trouble with the label 
> >for the root partition (Fedora system). Will investigate further when I 
> >get home tonight, unless something jumps out at anyone.
> >
> >kr
> 
> For clarification: This appears to be a problem in 2.6.9-rc3-mm3 also.

try root=/dev/sda3 (or whereever your root fs is) instead of
root=LABEL=/, in /etc/grub.conf.

	Ingo
