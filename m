Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWFLJPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWFLJPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFLJPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:15:54 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10708 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751206AbWFLJPx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:15:53 -0400
Subject: Re: 2.6.17-rc6-rt3
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060610082406.GA31985@elte.hu>
References: <20060610082406.GA31985@elte.hu>
Date: Mon, 12 Jun 2006 11:20:40 +0200
Message-Id: <1150104040.3835.3.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 11:19:33,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/06/2006 11:19:35,
	Serialize complete at 12/06/2006 11:19:35
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 10:24 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt3 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release: lots of fixes from Thomas Gleixner (for 
> the softirq problem that caused those ping latency weirdnesses, for 
> hrtimers and timers problems and for the RCU related bug that was 
> causing instability and more), John Stultz, Jan Altenberg and Clark 
> Williams. MIPS update from Manish Lachwani. Futex fix from Dinakar 
> Guniguntala. It also includes the RT-scheduling SMP fix that could fix 
> the scheduling problem reported by Darren Hart.
> 
> I think all of the regressions reported against rt1 are fixed, please 
> re-report if any of them is still unfixed.
> 

  Great, boots fine on my dual Xeon and solves the ping problem I was
having.

  Thomas, any hint at what was going on?

  Thanks,

  Sébastien.

