Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWAISO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWAISO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWAISO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:14:28 -0500
Received: from mail.gmx.net ([213.165.64.21]:50152 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964906AbWAISO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:14:27 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060109185052.00bef6c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 09 Jan 2006 19:14:19 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200601100308.05836.kernel@kolivas.org>
References: <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
 <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:08 AM 1/10/2006 +1100, Con Kolivas wrote:
>On Tuesday 10 January 2006 02:52, Mike Galbraith wrote:
> >
> > Anyway, if anyone wants to see a functional demonstration, just try
> > this.  Remove the TASK_NONINTERACTIVE in fs/pipe.c in both the stock kernel
> > and this modified one so Davide Libenzi's excellent sleep pattern exploit
> > (irman2) can work [1], and do the below all at the same time ...
> >
> > make -j4 bzImage
> > irman2
> > thud 3
> >...
>
>
>Want to try with a few other schedulers using plugsched?

Not really.  These exploits were specifically aimed at the current 
scheduler's Achilles Heel.  Besides, that carries implications of replacing 
this one, and I'm pretty fond of it.

         -Mike 

