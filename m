Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWDCMCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWDCMCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDCMCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:02:19 -0400
Received: from [212.33.185.14] ([212.33.185.14]:39184 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964811AbWDCMCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:02:18 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC] sched.c : procfs tunables
Date: Mon, 3 Apr 2006 14:59:43 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200603311723.49049.a1426z@gawab.com> <200604010044.09185.kernel@kolivas.org>
In-Reply-To: <200604010044.09185.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604031459.43105.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 01 April 2006 00:23, Al Boldi wrote:
> > Proper scheduling in a multi-tasking environment is critical to the
> > success of a desktop OS.  Linux, being mainly a server OS, is currently
> > tuned to scheduling defaults that may be appropriate only for the server
> > scenario.
> >
> > To enable Linux to play an effective role on the desktop, a more
> > flexible approach is necessary.  An approach that would allow the
> > end-User the freedom to adjust the OS to the specific environment at
> > hand.
> >
> > So instead of forcing a one-size fits all approach on the end-User,
> > would not exporting sched.c tunables to the procfs present a flexible
> > approach to the scheduling dilemma?
> >
> > All comments that have a vested interest in enabling Linux on the
> > desktop are most welcome, even if they describe other/better/smarter
> > approaches.
>
> None of the current "tunables" have easily understandable heuristics. Even
> those that appear to be obvious, like timselice, are not. While exporting
> tunables is not a bad idea, exporting tunables that noone understands is
> not really helpful.

Couldn't this be fixed with an autotuning module based on cpu/mem/ctxt 
performance?

Mike Galbraith wrote:
> Nope, not the existing tunables anyway.  The full effect of even a tiny
> scheduler knob tweak is hard to predict even if you've studied the code
> carefully.  These knobs are just not generic enough to be exposed IMHO.

Are you implying that the code is built around these tunables rather than 
using them?

Thanks!

--
Al

