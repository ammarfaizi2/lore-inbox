Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJRPrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJRPrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 11:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUJRPrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 11:47:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52891 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266703AbUJRPrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 11:47:20 -0400
Date: Mon, 18 Oct 2004 17:45:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041018154502.GA29032@elte.hu>
References: <OF7D12F73F.EA6A61CE-ON86256F31.0055E47B-86256F31.0055E4B1@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7D12F73F.EA6A61CE-ON86256F31.0055E47B-86256F31.0055E4B1@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> I will rebuild with -U5 since I noticed it is available, but if you
> have some suggestions on a way to capture more helpful data, I would
> be glad to do it.

-U5 has CONFIG_RWSEM_DEADLOCK_DETECT, which could help with your network
hangs.

	Ingo
