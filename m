Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVJGNZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVJGNZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVJGNZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:25:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9169 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932553AbVJGNZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:25:29 -0400
Date: Fri, 7 Oct 2005 15:26:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051007132606.GA3662@elte.hu>
References: <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510061122530.418@localhost.localdomain> <Pine.LNX.4.58.0510070706100.6608@localhost.localdomain> <20051007111544.GB857@elte.hu> <Pine.LNX.4.58.0510070810160.7222@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510070810160.7222@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Oct 2005, Ingo Molnar wrote:
> >
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > I was compiling a kernel in a shell that I set to a priority of 20,
> > > and it locked up on the bit_spin_lock crap of jbd.  Did you want me to
> > > send you that patch again that adds another spinlock to the buffer
> > > head and uses that instead of the bit_spins?
> >
> > yeah, please do.
> >
> 
> OK, here it is.  I tested it out by doing what locked up the first 
> time. Compiling the kernel under a shell with a priority of 20.
> 
> It survived a "make clean; make -j2".
> 
> -- Steve
> 
> patched against 2.6.14-rc3-rt10

thanks - applied.

	Ingo
