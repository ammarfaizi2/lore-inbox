Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272689AbTG1HOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272693AbTG1HOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:14:25 -0400
Received: from pop.gmx.net ([213.165.64.20]:16295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272689AbTG1HOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:14:24 -0400
Message-Id: <5.2.1.1.2.20030728093215.01be8f68@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 28 Jul 2003 09:33:47 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307281705.01471.kernel@kolivas.org>
References: <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
 <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
 <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:05 PM 7/28/2003 +1000, Con Kolivas wrote:
>On Mon, 28 Jul 2003 16:04, Mike Galbraith wrote:
> > to recharge his sleep_avg.  He stays low priority.  Kobiashi-maru:  X can't
>
> > Conclusion accuracy/inaccuracy aside, I'd like to see if anyone else can
> > reproduce that second scenario.
>
>Yes I can reproduce it, but we need the Kirk approach and cheat. Some
>workaround for tasks that have fallen onto the expired array but shouldn't be
>there needs to be created. But first we need to think of one before we can
>create one...

Oh good, it's not my poor little box.  My experimental tree already has a 
"Kirk" ;-)

         -Mike 

