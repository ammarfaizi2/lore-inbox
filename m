Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUIUP7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUIUP7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUIUP7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:59:42 -0400
Received: from mail.aei.ca ([206.123.6.14]:54505 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267700AbUIUP7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:59:40 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921073219.GA10095@elte.hu>
References: <1095714967.3646.14.camel@mars> <20040921073219.GA10095@elte.hu>
Content-Type: text/plain
Message-Id: <1095782377.3470.2.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 11:59:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 03:32, Ingo Molnar wrote:
> * Shane Shrybman <shrybman@aei.ca> wrote:
> 
> > I am having what appears to be IDE DMA problems with 2.6.9-rc2-mm1-S1.
> > 2.6.9-rc2-mm1 does not show this problem and runs fine. Before this I
> > was happily using 2.6.8-rc3-O5.
> > 
> > I tried booting with acpi=off but was unable to enter my user name at
> > the login prompt, it just hung with no response to sysreq. I also
> > tried turning off irq threading for that irq but it made no
> > difference.
> 
> does undoing (patch -R) the attached patch fix this IDE problem?
> 

Oh, I spoke too soon. A few minutes after I sent the last email the
problem re-appeared.

IRQ#22 thread started up.
hdg: dma_timer_expiry: dma status == 0x24
ALSA sound/core/pcm_native.c:1330: playback drain error (DMA or IRQ
trouble?)
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt

> 	Ingo

Regards,

Shane

