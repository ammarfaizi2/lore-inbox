Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272725AbTG1H4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272726AbTG1H4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:56:35 -0400
Received: from mail.gmx.de ([213.165.64.20]:15594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272725AbTG1H4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:56:32 -0400
Message-Id: <5.2.1.1.2.20030728100955.01bf5410@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 28 Jul 2003 10:15:55 +0200
To: Ingo Molnar <mingo@elte.hu>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Cc: Con Kolivas <kernel@kolivas.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307280935300.4596-100000@localhost.localdom
 ain>
References: <5.2.1.1.2.20030728093215.01be8f68@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:44 AM 7/28/2003 +0200, Ingo Molnar wrote:

>On Mon, 28 Jul 2003, Mike Galbraith wrote:
>
> > >Yes I can reproduce it, but we need the Kirk approach and cheat. Some
> > >workaround for tasks that have fallen onto the expired array but 
> shouldn't be
> > >there needs to be created. But first we need to think of one before we can
> > >create one...
> >
> > Oh good, it's not my poor little box.  My experimental tree already has
> > a "Kirk" ;-)
>
>could you give -G7 a try:
>
>         redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G7

The dd case is improved.  The dd if=/dev/zero is now prio 25, but it's 
of=/dev/null partner remains at 16.  No change with the xmms gl thread.

         -Mike 

