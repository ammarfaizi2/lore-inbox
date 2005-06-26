Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVFZSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVFZSOU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFZSOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 14:14:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:27356 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261532AbVFZSOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 14:14:17 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050626201018.02d2df48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 26 Jun 2005 20:14:10 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-os@analogic.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Possible spin-problem in nanosleep()
Cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1119806289.28649.12.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0506240733520.20914@chaos.analogic.com>
 <Pine.LNX.4.61.0506230812160.15775@chaos.analogic.com>
 <jell516ymn.fsf@sykes.suse.de>
 <Pine.LNX.4.61.0506230841390.15910@chaos.analogic.com>
 <Pine.LNX.4.61.0506231058560.16531@chaos.analogic.com>
 <1119546715.17066.20.camel@localhost.localdomain>
 <Pine.LNX.4.61.0506240733520.20914@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0525-4, 06/24/2005), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:18 PM 6/26/2005 +0100, Alan Cox wrote:
>On Gwe, 2005-06-24 at 12:42, Richard B. Johnson wrote:
> > Are you saying that each might get the CPU from between 0 and 1
> > tick, i.e., asynchronous with the tick? If so, depending upon the
> > phase between the timer-tick and when a task gets awakened, a task
> > may never get any CPU time at all. If so, this is a bug.
>
>No I'm saying the samping rate of the timer tick limits the resolution
>of accounting of data (ie straight information theory limits)

(precisely stated [again]) 

