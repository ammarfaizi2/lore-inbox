Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWGESMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWGESMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWGESMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:12:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42671 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964958AbWGESMa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:12:30 -0400
Subject: Re: [patch] i386: early pagefault handler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607050952190.12404@g5.osdl.org>
References: <200607050745_MC3-1-C42B-9937@compuserve.com>
	 <p73veqcp58s.fsf@verdi.suse.de> <44ABEB20.2010702@zytor.com>
	 <Pine.LNX.4.64.0607050952190.12404@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jul 2006 19:28:59 +0100
Message-Id: <1152124139.6533.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-05 am 09:54 -0700, ysgrifennodd Linus Torvalds:
> Anybody with that old a CPU will have learnt to to say "no-hlt" or 
> whatever the kernel command line is, and we could probably retire the 
> silly old hlt check (which I'm not even sure really ever worked).

The one specific case I know precisely details of was the Cyrix 5510. A
hlt by the CPU on that chipset during an IDE DMA transfer hangs the
system forever.

Its some years since I've even seen a 5510 and that check could be
automated anyway

Alan

