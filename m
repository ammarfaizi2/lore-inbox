Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbRAEPdy>; Fri, 5 Jan 2001 10:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRAEPdo>; Fri, 5 Jan 2001 10:33:44 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:1780 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S131964AbRAEPdb>;
	Fri, 5 Jan 2001 10:33:31 -0500
Message-ID: <3A55E937.4C67A08F@sls.lcs.mit.edu>
Date: Fri, 05 Jan 2001 10:33:11 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Burgess <Jon_Burgess@eur.3com.com>
CC: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <802569CB.005567CF.00@notesmta.eur.3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it is rev 78, but I have at least 20 of these working on other
machines (Precision 620) for a long time now.  The difference in this
machine is the i850 chipset vs. the i810 in the 620.

This seems to be a problem of 3c59x making a successful call of
request_irq(), but nothing shows up in /proc/interrupts.  It sounds like
something is getting dropped on the floor somewhere else.

I will try the patched driver on Andrew's web site.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
