Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVFOMt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVFOMt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVFOMtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:49:25 -0400
Received: from odin2.bull.net ([192.90.70.84]:47770 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261430AbVFOMtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:49:22 -0400
Subject: Re: network driver disabled interrupts in PREEMPT_RT
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613185642.GA12463@elte.hu>
References: <1118688347.5792.12.camel@localhost>
	 <20050613185642.GA12463@elte.hu>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1118839004.17063.19.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Wed, 15 Jun 2005 14:36:47 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 13/06/2005 à 20:56, Ingo Molnar a écrit :
> * Kristian Benoit <kbenoit@opersys.com> wrote:
> 
> > Hi,
> > I got lots of these messages when accessing the net running
> > 2.6.12-rc6-RT-V0.7.48-25 :
> > 
> > "network driver disabled interrupts: tg3_start_xmit+0x0/0x629 [tg3]"
> > 
> > it seem to come from net/sched/sch_generic.c.
> 
> does the patch below fix it?
> 
> 	Ingo
I have the same problem with an e1000 card for 2.6.12-rc6-RT-V0.7.48-32 :
#dmesg
...
network driver disabled interrupts: e1000_xmit_frame+0x0/0xbc0 [e1000]
...



