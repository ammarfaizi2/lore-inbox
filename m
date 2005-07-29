Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVG2JCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVG2JCR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVG2JCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:02:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46021 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262209AbVG2JCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:02:13 -0400
Date: Fri, 29 Jul 2005 11:01:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Message-ID: <20050729090122.GB8699@elte.hu>
References: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <42E9ED47.1030003@yahoo.com.au> <20050729085340.GA8699@elte.hu> <42E9EFDD.4020703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9EFDD.4020703@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>processes    1               2               3              4
> >>
> >>2.6.13-rc4:  187, 183, 179   260, 259, 256   340, 320, 349  504, 496, 500
> >>no wake-bal: 180, 180, 177   254, 254, 253   268, 270, 348  345, 290, 500
> >>
> >>Numbers are MB/s, higher is better.
> >
> >
> >what type of network was used - localhost or a real one?
> >
> 
> Localhost. Yeah it isn't a real world test, but it does show the 
> erratic behaviour without wake affine.

yeah - fine enough. (It's not representative for IO workloads, but it's 
representative for local IPC workloads, just wanted to know precisely 
which workload it is.)

	Ingo
