Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTDAJ7l>; Tue, 1 Apr 2003 04:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbTDAJ7l>; Tue, 1 Apr 2003 04:59:41 -0500
Received: from ns.suse.de ([213.95.15.193]:33809 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262219AbTDAJ7k>;
	Tue, 1 Apr 2003 04:59:40 -0500
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
In-Reply-To: <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com> 
	<Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Apr 2003 12:11:00 +0200
Message-Id: <1049191863.30759.3.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 10:22, Zwane Mwaikambo wrote:
> On Tue, 1 Apr 2003, Zwane Mwaikambo wrote:
> 
> > +config X86_SSE
> > +	bool
> > +	depends on MK7 || MPENTIUMIII || MVIAC3_2
> > +	default y
> > +
> 
> Bad option to flag against as pointed out by someone, seeing as K7 
> implimented half the SSE instructions.

SSE2 != SSE1. K7 has SSE1, like the Pentium 3.

X86_SSE is SSE1

sfence is part of SSE2. That's X86_SSE2

-Andi


