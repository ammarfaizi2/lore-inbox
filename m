Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVL1X4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVL1X4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 18:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVL1X4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 18:56:46 -0500
Received: from khc.piap.pl ([195.187.100.11]:6148 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932556AbVL1X4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 18:56:45 -0500
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
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 29 Dec 2005 00:56:41 +0100
In-Reply-To: <20051228214845.GA7859@elte.hu> (Ingo Molnar's message of "Wed,
 28 Dec 2005 22:48:45 +0100")
Message-ID: <m3fyoc4vye.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

>>    gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)

> another thing: i wanted to decrease the size of -Os 
> (CONFIG_CC_OPTIMIZE_FOR_SIZE) kernels, which e.g. Fedora uses too (to 
> keep the icache footprint down).

Remember the above gcc miscompiles the x86-32 kernel with -Os:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764
-- 
Krzysztof Halasa
