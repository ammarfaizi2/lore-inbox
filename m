Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVFONJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVFONJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 09:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFONJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 09:09:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38799 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261441AbVFONJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 09:09:27 -0400
Date: Wed, 15 Jun 2005 15:05:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: network driver disabled interrupts in PREEMPT_RT
Message-ID: <20050615130511.GA376@elte.hu>
References: <1118688347.5792.12.camel@localhost> <20050613185642.GA12463@elte.hu> <1118839004.17063.19.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1118839004.17063.19.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Le lun 13/06/2005 à 20:56, Ingo Molnar a écrit :
> > * Kristian Benoit <kbenoit@opersys.com> wrote:
> > 
> > > Hi,
> > > I got lots of these messages when accessing the net running
> > > 2.6.12-rc6-RT-V0.7.48-25 :
> > > 
> > > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> > > 
> > > it seem to come from net/sched/sch_generic.c.
> > 
> > does the patch below fix it?
> > 
> > 	Ingo
> I have the same problem with an e1000 card for 2.6.12-rc6-RT-V0.7.48-32 :
> #dmesg
> ...
> network driver disabled interrupts: e1000_xmit_frame+0x0/0xbc0 [e1000]
> ...

does -48-33 fix it for you?

	Ingo
