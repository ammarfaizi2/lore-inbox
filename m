Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316231AbSEVQLu>; Wed, 22 May 2002 12:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316226AbSEVQKi>; Wed, 22 May 2002 12:10:38 -0400
Received: from loisexc2.loislaw.com ([12.5.234.240]:29964 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S316232AbSEVQK0>; Wed, 22 May 2002 12:10:26 -0400
Message-ID: <4188788C3E1BD411AA60009027E92DFD0962E2C4@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Doug McNaught'" <doug@wireboard.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: RedHat 7.2 Stock SMP Install
Date: Wed, 22 May 2002 11:10:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Doug McNaught [mailto:doug@wireboard.com]
> Sent: Wednesday, May 22, 2002 10:32 AM
> To: Rose, Billy
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PROBLEM: RedHat 7.2 Stock SMP Install
> 
> 
> "Rose, Billy" <wrose@loislaw.com> writes:
> 
> > I have an HP LPr Dual P-III 550 with 2 18G SCSI drives that locked
>  up.
> 
> > Linux warnock 2.4.7-10smp #1 SMP Thu Sep 6 17:09:31 EDT 
> 2001 i686 unknown
>                 ^^^^^^^^^^^
> Try the latest errata kernel for 7.2 and see if it still happens.
> There's a reason they release kernel update packages...

I looked on RH before sending the original post. There's a reason you don't
upgrade a live RedHat machine running Tux for (what is listed to be)
security fixes that do not pertain to a particular machine, without more
knowledge of the crash. I have taken your advice (and Mr. Benjamin
LaHaise's) and upgraded a _sandbox_ machine to see how Tux will behave
during and after the upgrade. With Tux, simply upgrading/installing a new
kernel is not easy as there are incompatibilities between different versions
of the userspace and kernel space portions when version numbers are in a
mixed state (i.e. the upgrade hoses everything and you fall back to the
known kernel). Installing/upgrading to the latest errata kernel requires
Tux's userspace stuff to be upgraded first... If the new kernel dies, my old
kernel will still boot, but Tux may not work (the primary job of said
server) because the userspace stuff is now incompatible. FYI, the machine in
question typically handles 4X the requests as it's brethren NT machines next
to it -- hats off to all you guys!

Billy Rose 
wrose@loislaw.com> 

> -Doug
> 
