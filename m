Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276933AbRJHPXZ>; Mon, 8 Oct 2001 11:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276938AbRJHPXP>; Mon, 8 Oct 2001 11:23:15 -0400
Received: from [216.191.240.114] ([216.191.240.114]:36485 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276933AbRJHPXE>;
	Mon, 8 Oct 2001 11:23:04 -0400
Date: Mon, 8 Oct 2001 11:20:32 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrea Arcangeli <andrea@suse.de>,
        Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15qcES-0000rh-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.30.0110081117140.5473-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Oct 2001, Alan Cox wrote:

> It doesnt save you from horrible performance. NAPI is there to do that, it
> saves you from a dead box. You can at least rmmod the cardbus controller
> with protection in place (or go looking for the problem with a debugger)

I hear you, but I think isolation is important;
If i am telneted (literal example here) onto that machine (note eth0 is
not cardbus based) and cardbus is causing the loops then iam screwed.
[The same applies to everything that shares interupts]

cheers,
jamal

