Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVAXSYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVAXSYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVAXSYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:24:20 -0500
Received: from novell.stoldgods.nu ([193.45.238.241]:61605 "EHLO
	novell.stoldgods.nu") by vger.kernel.org with ESMTP id S261556AbVAXSYJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:24:09 -0500
From: Magnus =?iso-8859-1?q?M=E4=E4tt=E4?= <novell@kiruna.se>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.11-rc2
Date: Mon, 24 Jan 2005 19:23:55 +0100
User-Agent: KMail/1.7.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org> <200501232211.45924.novell@kiruna.se> <20050124104307.GB3515@stusta.de>
In-Reply-To: <20050124104307.GB3515@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501241923.56593.novell@kiruna.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 24 January 2005 11.43, Adrian Bunk wrote:
> On Sun, Jan 23, 2005 at 10:11:45PM +0100, Magnus Määttä wrote:
> > Hello
>
> Hi Magnus,
>
> > It doesn't compile here, here's the error:
> >
> >   CC      net/sched/sch_generic.o
> > net/sched/sch_generic.c: In function `qdisc_restart':
> > net/sched/sch_generic.c:128: error: label `requeue' used but not
> > defined
> > make[2]: *** [net/sched/sch_generic.o] Error 1
> > make[1]: *** [net/sched] Error 2
> > make: *** [net] Error 2
>
> I wasn't able to reproduce your problem.
>
> Do you have any patches applied on top of 2.6.11-rc2 ?

Sorry about the noise. I forgot that I had Ingo's realtime preempt 
patch applied (just saw that it was fixed anyway). I guess this is 
what happens when you're compiling on several systems at once 
(patched vs. unpatched ones).


Magnus

-- 
panic("huh?\n");
        linux-2.2.16/arch/i386/kernel/smp.c
