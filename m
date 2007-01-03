Return-Path: <linux-kernel-owner+w=401wt.eu-S1750738AbXACMjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXACMjp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 07:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXACMjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 07:39:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57733 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbXACMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 07:39:44 -0500
Date: Wed, 3 Jan 2007 13:35:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH 2.6.19.1-rt15][RFC] - futex_requeue_pi implementation (requeue from futex1 to PI-futex2)
Message-ID: <20070103123536.GA9088@elte.hu>
References: <459BA267.1020706@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459BA267.1020706@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> Hi,
> 
> First, thanks Ingo for your comments on my previous mail from 
> december. I've taken all your remarks into account.
> 
> The 64-bit and compat versions have been implemented and tested. The 
> glibc part has also been updated and the x86_64 version is now 
> implemented too.
> 
> Here after is the updated patch for kernel 2.6.19-rt15.

looks good to me in principle. The size of the patch is scary - is there 
really no simpler way? Also, could you send me a patch against a 
20-rc3-rt0-ish kernel so that i can stick this into -rt for testing?

	Ingo
