Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVL2ToP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVL2ToP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 14:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVL2ToP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 14:44:15 -0500
Received: from khc.piap.pl ([195.187.100.11]:7940 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750926AbVL2ToP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 14:44:15 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051228114637.GA3003@elte.hu>
	<Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	<1135798495.2935.29.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	<20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	<m3fyoc4vye.fsf@defiant.localdomain> <20051229074107.GB20177@elte.hu>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 29 Dec 2005 20:44:10 +0100
In-Reply-To: <20051229074107.GB20177@elte.hu> (Ingo Molnar's message of
 "Thu, 29 Dec 2005 08:41:07 +0100")
Message-ID: <m3acejsn79.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

>> Remember the above gcc miscompiles the x86-32 kernel with -Os:
>> 
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764
>
> i'm not sure what the point is.

Nothing special, just a side note.

> There was no sudden rush of -Os related 
> bugs when Fedora switched to it for the kernel,

I found 'ip route add' was broken with -Os. I use FC4s but the kernel
is usually a mutated version of the Linus' tree so I can't check it.

> and the 35% code-size 
> savings were certainly worth it in terms of icache footprint.

Sure.

Good to hear gcc 4.1 is fixed.
-- 
Krzysztof Halasa
