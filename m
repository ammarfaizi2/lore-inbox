Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVA0Qn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVA0Qn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVA0Qn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:43:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:5306 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262575AbVA0Qnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:43:52 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050127172657.00bd6410@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Thu, 27 Jan 2005 17:31:12 +0100
To: Ingo Molnar <mingo@elte.hu>, Cal <hihone@bigpond.net.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D8
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
In-Reply-To: <20050127085120.GF22482@elte.hu>
References: <41F84BDF.3000506@bigpond.net.au>
 <20050124125814.GA31471@elte.hu>
 <20050125135613.GA18650@elte.hu>
 <41F6C5CE.9050303@bigpond.net.au>
 <41F6C797.80403@bigpond.net.au>
 <20050126100846.GB8720@elte.hu>
 <41F7C2CA.2080107@bigpond.net.au>
 <87acqwnnx1.fsf@sulphur.joq.us>
 <41F7DA1B.5060806@bigpond.net.au>
 <87vf9km31j.fsf@sulphur.joq.us>
 <41F84BDF.3000506@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0453-1, 12/31/2004), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:51 AM 1/27/2005 +0100, Ingo Molnar wrote:

>* Cal <hihone@bigpond.net.au> wrote:
>
> > Sorry for the delay, some sleep required. A build without SMP also
> > fails, with multiple oops.
> >   <http://www.graggrag.com/200501271213-oops/>.
>
>thanks, this pinpointed the bug - i've uploaded the -D8 patch to the
>usual place:
>
>   http://redhat.com/~mingo/rt-limit-patches/
>
>does it fix your crash? Mike Galbraith reported a crash too that i think
>could be the same one.

Yeah, my crash log is 120KB longer, but it looks the same, and is also 
fixed by D8.

         -Mike 

