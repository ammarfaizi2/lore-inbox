Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262458AbSI2MiZ>; Sun, 29 Sep 2002 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262463AbSI2MiZ>; Sun, 29 Sep 2002 08:38:25 -0400
Received: from h004.c015.snv.cp.net ([209.228.35.119]:24249 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id <S262458AbSI2MiZ>;
	Sun, 29 Sep 2002 08:38:25 -0400
X-Sent: 29 Sep 2002 12:43:47 GMT
Date: Sun, 29 Sep 2002 14:41:09 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel crashes when recording audio
Message-ID: <20020929124109.GB2887@cornils.net>
References: <200209291128.NAA21889@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209291128.NAA21889@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
From: Malte Cornils <mcornils@cornils.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 29, 2002 at 01:28:53PM +0200, Mikael Pettersson wrote:
> smp_apic_timer_interrupt is also used in UP local APIC kernels.
> You're either running an SMP kernel on a UP box, or a local APIC
> enabled kernel.

CONFIG_SMP is not set, CONFIG_X86_LOCAL_APIC is enabled.

> You got a page fault in ack_APIC_irq(). This should never happen.

That's quite cool :-) How can I prevent this from happening then? Hmm...
BTW, I got the same error on 2.4.19, with ALSA it works fine.

-Malte #8-)
