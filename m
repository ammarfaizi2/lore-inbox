Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVCOKJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVCOKJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 05:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVCOKJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 05:09:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62944 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262371AbVCOKJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 05:09:11 -0500
Date: Tue, 15 Mar 2005 11:09:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, andrea@cpushare.com,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315100903.GA32198@elte.hu>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random> <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303135556.5fae2317.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > My point is simply:
> > 
> >  The help text for an option you need only under very specific 
> >  circumstances shouldn't sound as if this option was nearly was 
> >  mandatory.
> 
> I think the sort of sell-your-cycles service which this patch enables is a
> neat idea, and one which is worth supporting, especially as the kernel
> patch is so tiny.  So we want as many machines as possible to support it. 
> So people don't need a special kernel just to join in.
> 
> Others may disagree, although nobody has.
> 
> And the patch is tiny.

see my earlier counter-arguments in the thread starting at:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=110630922022462&w=2

end result of the thread: seccomp is completely unnecessary code-bloat
and can be equivalently implemented via ptrace. I cannot believe this
made it into -BK ...

	Ingo
