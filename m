Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUJHHBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUJHHBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUJHHBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:01:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42963 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268108AbUJHHBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 03:01:36 -0400
Date: Fri, 8 Oct 2004 09:02:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041008070252.GA30823@elte.hu>
References: <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <4165832E.1010401@cybsft.com> <4165A729.5060402@cybsft.com> <20041007215546.GA8541@elte.hu> <4165F050.5050904@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4165F050.5050904@cybsft.com>
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

> Ingo Molnar wrote:
> >* K.R. Foley <kr@cybsft.com> wrote:
> >
> >
> >>>For me, this one wants to panic on boot when trying to find the root 
> >>>filesystem. Acts like either the aic7xxx module is missing (which I 
> >>>don't think is the case) or hosed, or it's having trouble with the label 
> >>>for the root partition (Fedora system). Will investigate further when I 
> >>>get home tonight, unless something jumps out at anyone.
> >>>
> >>>kr
> >>
> >>For clarification: This appears to be a problem in 2.6.9-rc3-mm3 also.
> >
> >
> >try root=/dev/sda3 (or whereever your root fs is) instead of
> >root=LABEL=/, in /etc/grub.conf.
> >
> >	Ingo
> >
> 
> Thanks. Tried that just to be sure. However, I don't seem to be the
> only one having this problem with aic7xxx.

could you send me the following info:

  - full log of a failed boot
  - full log of a successful boot
  - the output of 'mount'

	Ingo
