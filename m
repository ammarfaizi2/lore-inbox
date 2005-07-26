Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVGZO6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVGZO6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVGZO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:56:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16535 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261837AbVGZOzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:55:36 -0400
Date: Tue, 26 Jul 2005 16:55:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 PREEMPT_RT && PPC
Message-ID: <20050726145500.GA18752@elte.hu>
References: <200507200816.11386.kernel@kolivas.org> <20050719223216.GA4194@elte.hu> <1121819037.26927.75.camel@dhcp153.mvista.com> <200507201104.48249.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <42DF293A.4050702@timesys.com> <20050726120015.GB9224@elte.hu> <42E64C43.2050104@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E64C43.2050104@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> <snip>
> 
> On X86 -51-36 won't build with CONFIG_BLOCKER=Y without the attached 
> patch.

thanks. I changed the include to asm/rtc.h, this should give what PPC 
wants to have, and should work on all architectures. Released the -37 
patch.

	Ingo
