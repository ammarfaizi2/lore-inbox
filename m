Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRGEODe>; Thu, 5 Jul 2001 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264924AbRGEODY>; Thu, 5 Jul 2001 10:03:24 -0400
Received: from gherkin.sa.wlk.com ([192.158.254.49]:44548 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S263918AbRGEODG>; Thu, 5 Jul 2001 10:03:06 -0400
Message-Id: <m15I9iY-0005khC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <E15I9Oy-0002av-00@the-village.bc.nu> "from Alan Cox at Jul 5, 2001
 02:42:40 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 5 Jul 2001 09:02:54 -0500 (CDT)
CC: "Bob_Tracy" <rct@gherkin.sa.wlk.com>, dmircea@kappa.ro,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Something I forgot to mention that I didn't see in any of the other
> > problem reports.  In my case, the panic happens immediately after
> > "Calibrating delay loop" appears during the boot sequence.
> 
> Duplicated here. Works fine on a non Cyrix processor with the same kernel image.
> Perhaps the folks who submitted the 2.4.6 tasklet changes could review them ?

Definitely *not* "APIC support on uniprocessor" related.  At least one
of the posted configurations had that option disabled.

--Bob
