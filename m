Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272734AbTG1I11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272728AbTG1I11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:27:27 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:26530
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272734AbTG1I10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:27:26 -0400
Message-ID: <1059381752.3f24e1f8ad4b5@kolivas.org>
Date: Mon, 28 Jul 2003 18:42:32 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
References: <5.2.1.1.2.20030728093215.01be8f68@pop.gmx.net> <5.2.1.1.2.20030728100955.01bf5410@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030728100955.01bf5410@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Galbraith <efault@gmx.de>:

> At 09:44 AM 7/28/2003 +0200, Ingo Molnar wrote:
> 
> >On Mon, 28 Jul 2003, Mike Galbraith wrote:
> >
> > > >Yes I can reproduce it, but we need the Kirk approach and cheat. Some
> > > >workaround for tasks that have fallen onto the expired array but 
> > shouldn't be
> > > >there needs to be created. But first we need to think of one before we
> can
> > > >create one...
> > >
> > > Oh good, it's not my poor little box.  My experimental tree already has
> > > a "Kirk" ;-)
> >
> >could you give -G7 a try:
> >
> >         redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G7
> 
> The dd case is improved.  The dd if=/dev/zero is now prio 25, but it's 
> of=/dev/null partner remains at 16.  No change with the xmms gl thread.

Well O10 is not prone to the dd/of problem (obviously since it doesn't use 
nanosecond timing [yet?]) but I can exhibit your second weird one if I try hard 
enough.

Con
