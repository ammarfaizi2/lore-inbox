Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276532AbRJ0TNh>; Sat, 27 Oct 2001 15:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276489AbRJ0TN1>; Sat, 27 Oct 2001 15:13:27 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:30986 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S276052AbRJ0TNT>; Sat, 27 Oct 2001 15:13:19 -0400
Message-ID: <002801c15f19$a4833d50$3a01a8c0@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Igor Mozetic" <igor.mozetic@uni-mb.si>, <linux-kernel@vger.kernel.org>
In-Reply-To: <15322.33513.293148.371409@cmb1-3.dial-up.arnes.si>
Subject: Re: Any stable 2.4 kernel?
Date: Sat, 27 Oct 2001 15:00:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if anybody has found a stable kernel for the following
> hardware: C440GX+, dual Xeon 550, 2GB RAM, 1GB swap, aic7xxx.
> Usage pattern is load > 2, highmem, not much I/O (maybe swap?).
> Some of our jobs take weeks, so stable means months between reboots.

> I found anything beyond 2.4.10 useless - lockups after a few days.
> Currently I run 2.4.3 with varying degree of success - initial lifespan
> was 4 months, but last reincarnation survived for 3 weeks only.

I'll offer a few suggestions.

What particular distribution are you using?  If using a commercial
distribution like SuSE or Redhat have you tried the kernels that they
provide.  I've generally found these kernels to be very stable as both of
these vendors perform fairly rigorous testing before making a kernel release
to the public.

The next suggestion would be to actually attempt to determine the reason for
the crash and see if it can be fixed.  I would generally agree that your
problem is probably with highmem, and since 2.4.10 was when Andrea's VM went
in (i think) maybe that's why kernels after that point are worse for you.
Perhaps try a recent -ac kernel and see what they act like.

> Any recommendation for 2.4 or should I consider going back to 2.2 ?
> I don't need any fancy features (apart to SMP and highmem),
> only stability is important.

Well, I still run 2.2 on all the machines that need 100% reliability, and
while I also have several 2.4.x machines that have achieved 200+ day
uptimes, they are all single processor <512MB RAM machines.  The 2.2 servers
are all dual or quad processor with  >2GB RAM and all seven achived 150+ day
uptimes, although I'll finally have to reboot them all soon to apply the
recent SuSE kernel updates for the recent security exploits (even though I'm
fairly low risk for them I thought it was a good excuse to schedule
maintanence).  I'm currently testing one of the machines with the 2.4.7
kernel from SuSE, but I'm still not ready to make the jump on the really
loaded machines.

Later,
Tom


