Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbRGRAah>; Tue, 17 Jul 2001 20:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267670AbRGRAa0>; Tue, 17 Jul 2001 20:30:26 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:4237 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267564AbRGRAaV>; Tue, 17 Jul 2001 20:30:21 -0400
Message-ID: <3B54D8FB.F5EA4B57@uow.edu.au>
Date: Wed, 18 Jul 2001 10:31:55 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
In-Reply-To: Andrew Morton's message of Wed, 18 Jul 2001 00:00:54 +1000.,
		<200107171322.HAA245907@ibg.colorado.edu> <3B544516.FF6643E8@uow.edu.au> <200107171615.KAA254078@ibg.colorado.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Lessem wrote:
> 
> >For interest's sake, could you please try booting with the
> >`noapic' option, and also send another NMI watchdog trace?
> 
> I tried that, but the Symbios SCSI controller freaks out with noapic.
> I can be more detailed if that would be useful.

Please do - that sounds like a strange interaction.

> I can also try a
> non-smp kernel and run the machine with 1 processor and 8GB, if you
> think that would be useful in solving the problem.

May as well - all data is good data.

Can you please send a couple more ksymoops traces from the
NMI watchdog trap?

Have you tried 2.2.19, 2.4.4 and -ac kernels? 

-
