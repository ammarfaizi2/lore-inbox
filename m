Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVGGUTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVGGUTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGGURM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:17:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:23223 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261352AbVGGUOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:14:48 -0400
Date: Thu, 7 Jul 2005 22:14:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-RT-V0.7.51-12 and x86-64
Message-ID: <20050707201444.GB2905@elte.hu>
References: <200507072106.31970.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507072106.31970.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Latest patch doesn't compile on non-i386 arches. I found all users of 
> INIT_FS; need to be audited to INIT_FS(init_fs); like i386; then it 
> compiles fine.

thx, i've put this fix into -51-14.

> Ingo, could you also respond to my other thread, I uploaded the 
> screenshot you requested.

unfortunately they dont show any other info, other than somewhere a 
pagefault happened. I suspect only serial logging would help.

	Ingo
