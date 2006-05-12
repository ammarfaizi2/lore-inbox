Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWELH3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWELH3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWELH3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:29:09 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:24211 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750700AbWELH3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:29:08 -0400
Subject: Re: rt20 patch question
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Hounschell <markh@compro.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net>
	 <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <4460ADF8.4040301@compro.net>
	 <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
	 <4461E53B.7050905@compro.net>
	 <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
	 <446207D6.2030602@compro.net>
	 <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com>
	 <44623157.9090105@compro.net>
	 <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
	 <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net>
	 <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com>
	 <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com>
	 <446335EA.3000506@compro.net>
	 <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com>
	 <44633B78.8080907@compro.net>
	 <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com>
	 <446350CF.3010204@compro.net>
	 <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com>
Date: Fri, 12 May 2006 09:33:21 +0200
Message-Id: <1147419202.3969.51.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 09:32:01,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 12/05/2006 09:32:07,
	Serialize complete at 12/05/2006 09:32:07
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 02:47 -0400, Steven Rostedt wrote:
> On Thu, 11 May 2006, Mark Hounschell wrote:
> 
> >
> > Here is a detailed list of the RT tasks running with prios, cpu masks
> > etc. There are 3 nics. eth1 is the nic being used by the emulation. eth2
> > is currently unused.
> 
> >
> > pid      SCHED        PRIO      CPUM TASK
> > ---      ----         ----      ---- ----
> 
> This being a SMP machine, pid 2 and 3 must be the migration threads.
> 
> > 2        FIFO         99           1 (unknown)
> > 3        FIFO         99           1 (unknown)
> 
> > 4        FIFO         1            1 (unknown)
> > 5        FIFO         1            1 (unknown)
> > 6        FIFO         1            1 (unknown)
> > 7        FIFO         1            1 (unknown)
> > 8        FIFO         1            1 (unknown)
> > 9        FIFO         1            1 (unknown)
> > 10       FIFO         1            1 (unknown)
> 
> Do you know what these processes are (12 and 13)?

  On my machine, the only other processes runnning at prio 99 are
the posix_cpu_timer tasks.

> 
> > 12       FIFO         99           2 (unknown)
> > 13       FIFO         99           2 (unknown)
> 
> [...]
> 

  Hope this helps.

  Sébastien.

