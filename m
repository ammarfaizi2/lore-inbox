Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269600AbUJLKf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269600AbUJLKf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbUJLKf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:35:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45269 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269600AbUJLKdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:33:53 -0400
Date: Tue, 12 Oct 2004 12:35:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012103512.GA24836@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <1097573492.6157.26.camel@libra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097573492.6157.26.camel@libra>
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


* Wen-chien Jesse Sung <jesse@cola.voip.idv.tw> wrote:

> > this should fix the UP build issues reported by many. -T6 also brings
> > back the ->break_lock framework and converts a few more locks to raw.
> 
> UP build is still failed: 
>  arch/i386/kernel/vm86.c:707: error: `__RAW_SPIN_LOCK_UNLOCKED'
> undeclared here (not in a function)

ok, fixed this one too and re-uploaded -T6 - please check whether it
builds for you now.

	Ingo
