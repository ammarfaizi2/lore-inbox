Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWGYEz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWGYEz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGYEz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:55:56 -0400
Received: from [212.70.37.245] ([212.70.37.245]:14344 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932454AbWGYEzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:55:46 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Tue, 25 Jul 2006 07:57:10 +0300
User-Agent: KMail/1.5
References: <200607241857.52389.a1426z@gawab.com>
In-Reply-To: <200607241857.52389.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607250757.10722.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> This version removes the hard/soft CPU rate caps from the SPA
> >> schedulers.
> >>
> >> A patch for 2.6.18-rc2 is available at:
> >>
> >> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.18-rc2.
> >>pat ch?download>
> >>
> >> Very Brief Documentation:
> >>
> >> You can select a default scheduler at kernel build time.  If you wish
> >> to boot with a scheduler other than the default it can be selected at
> >> boot time by adding:
> >>
> >> cpusched=<scheduler>
> >
> > Any reason dynsched couldn't be merged with plugsched?
>
> None that I know of (but I'm not familiar with dynsched).  Patches to
> add it to the mix would be accepted and once in I would try to keep it
> in step with kernel changes.

I thought dynsched patches against plugsched, what else is needed?

> >> to the boot command line where <scheduler> is one of: ingosched,
> >> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
> >> or zaphod.  If you don't change the default when you build the kernel
> >> the default scheduler will be ingosched (which is the normal
> >> scheduler).
> >>
> >> The scheduler in force on a running system can be determined by the
> >> contents of:
> >>
> >> /proc/scheduler
> >
> > It may be really great, to allow schedulers perPid parent, thus allowing
> > the stacking of different scheduler semantics.  This could aid
> > flexibility a lot.
>
> I'm don't understand what you mean here.  Could you elaborate?

i.e:  Boot the kernel with spa_no_frills, then start X with spa_ws.


Thanks!

--
Al

