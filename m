Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUH3NnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUH3NnC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUH3NnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:43:02 -0400
Received: from gepard.lm.pl ([212.244.46.42]:17316 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S268039AbUH3Nm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:42:57 -0400
Subject: Re: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
	mode:0x20
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040829160257.3b881fef.akpm@osdl.org>
References: <1093794970.1751.10.camel@rakieeta>
	 <20040829160257.3b881fef.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: o2.pl Sp z o.o.
Message-Id: <1093873300.1789.13.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 15:41:40 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z pon, 30-08-2004, godz. 01:02, Andrew Morton pisze: 
> Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
> >
> > after creating several GB of data in small files on the SMP highmem box
> >  the
> > 
> >  kjournald: page allocation failure. order:1, mode:0x20
> > 
> > 
> >  start flooding the logs, load goes to sth around 1k, writing processes
> >  get stuck in D state and the system needs hard reset.
> > 
> >  Anyone else is experiencing that kind of problems?
> > 
> >  Im running sw raid1 on that box, not preemtible kernel.
> 
> There should have been a stack trace as well.  Please send it.

Sadly I don't have the stack for kjournald process however I have
similiar traces, please see the attached file. 2.6.9-rc1-mm1 SMP,
highmem.

Hope that can give you some more information.

Krzysztof

