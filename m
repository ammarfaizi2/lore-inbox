Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRB0RGJ>; Tue, 27 Feb 2001 12:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129546AbRB0RGA>; Tue, 27 Feb 2001 12:06:00 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:33523 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129609AbRB0RFq>; Tue, 27 Feb 2001 12:05:46 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102271705.f1RH5bB27105@webber.adilger.net>
Subject: Re: Dynamically altering code segments
In-Reply-To: <A490B2C9C629944E85CE1F394138AF957FC3E1@bignorse.SURGIENT.COM> from
 "Collins, Tom" at "Feb 27, 2001 10:43:02 am"
To: "Collins, Tom" <Tom.Collins@surgient.com>
Date: Tue, 27 Feb 2001 10:05:37 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Collins writes:
> I am wanting to dynamically modify the kernel in specific places to
> implement a custom kernel trace mechanism.  The general idea is that,
> when the "trace" is off, there are NOP instruction sequences at various
> places in the kernel.  When the "trace" is turned on, those same NOPs
> are replaced by JMPs to code that implements the trace (such as logging
> events, using the MSR and PMC's etc..).
> 
> This was a trick that was done in my old days of OS/2 performance tools 
> developement to get trace information from the running kernel.
> 
> Is it possible to do the same thing in Linux?

See IBM "dprobes" project.  It is basically what you are describing
(AFAIK).  It makes sense, because a lot of the OS/2 folks are now working
on Linux.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
