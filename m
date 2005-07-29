Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVG2KxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVG2KxA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVG2Kw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:52:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43984 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262573AbVG2Kwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:52:46 -0400
Date: Fri, 29 Jul 2005 12:52:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729105211.GA23355@elte.hu>
References: <20050728090948.GA24222@elte.hu> <200507281914.j6SJErg31398@unix-os.sc.intel.com> <20050729070447.GA3032@elte.hu> <20050729070702.GA3327@elte.hu> <1122628675.14892.9.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122628675.14892.9.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> code like that always makes me think of duffs-device
>   http://www.lysator.liu.se/c/duffs-device.html
> 
> although it might be that the compiler generates better code from the 
> current incarnation; just my .02 ;-)

yeah, will do that. First wanted to see whether it's worth it.

	Ingo
