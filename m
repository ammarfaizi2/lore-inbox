Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbVHYQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbVHYQyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHYQyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:54:03 -0400
Received: from bay14-f20.bay14.hotmail.com ([64.4.49.20]:12473 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751047AbVHYQyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:54:02 -0400
Message-ID: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl>
X-Originating-IP: [65.202.146.101]
X-Originating-Email: [duquesnay@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0508251138220.3971@chaos.analogic.com>
From: "Chris du Quesnay" <duquesnay@hotmail.com>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building the kernel with Cygwin
Date: Thu, 25 Aug 2005 16:54:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Aug 2005 16:54:01.0946 (UTC) FILETIME=[983FB3A0:01C5A995]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick.  Thanks for your suggestion.

I tried it, however, and attempted the make again, and got the same error.

The scripts/basic directory contains a fixdep.exe after the make is run.  
There is
no fixdep file.  I tried renaming the fixdep.exe to fixdep, but that also 
resulted in
the same make error.

Any further suggestions?
Thx,
Chris.


>From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>To: "Chris du Quesnay" <duquesnay@hotmail.com>
>CC: <linux-kernel@vger.kernel.org>
>Subject: Re: Building the kernel with Cygwin
>Date: Thu, 25 Aug 2005 11:42:46 -0400
>
>
>On Thu, 25 Aug 2005, Chris du Quesnay wrote:
>
> > Hi.  I am newbie at GNU/linux.
> >
> > I am trying to build a kernel (2.6.12)  for a powerpc target using 
>cygwin on
> > my i686 machine.  I have
> > Windows 2000 as my operating system.
> >
> > I have recent versions of cygwin (with GNU make 3.80), binutils for the
> > powerpc (gcc v 3.3.1, ld v 2.14)
> >
> > I set
> > ARCH=ppc
> > CROSS_COMPILE= powerpc-ibm-eabi-
> >
> > and I add the cross compiler/build directory to my path.
> >
> > After untaring the kernel, I issue the
> > make mrproper, which appears to work.
> >
> > Then I issue
> > make menuconfig
> >
> > and I get the following error, which I can't seem to get around:
> >
> > HOSTCC   scripts/basic/fixdep
> > fixdep: no such file or directory
> > make[1]:*** [scripts/basic/fixdep] Error 2
> > make[1] Leaving directory /cygdrive/c/Linux_amcc/linux-2.6.12
> >
> >
> > Can you suggest what the problem might be?  Should I be able to build 
>the
> > kernel
> > with cygwin?
> >
>
>Try this temporary work-around:
>
>cd /cygdrive/c/Linux_amcc/linux-2.6.12/scripts/basic
>gcc -O2 -o fixdep fixdep.c
>
>You may also have to do the same thing for docproc, i.e.,
>gcc -O2 -o docproc docproc.c
>
>Others may tell you what's wrong, but at least this should get
>you started.
>
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
>Warning : 98.36% of all statistics are fiction.
>.
>I apologize for the following. I tried to kill it with the above dot :
>
>****************************************************************
>The information transmitted in this message is confidential and may be 
>privileged.  Any review, retransmission, dissemination, or other use of 
>this information by persons or entities other than the intended recipient 
>is prohibited.  If you are not the intended recipient, please notify 
>Analogic Corporation immediately - by replying to this message or by 
>sending an email to DeliveryErrors@analogic.com - and destroy all copies of 
>this information, including any attachments, without reading or disclosing 
>them.
>
>Thank you.

_________________________________________________________________
Take advantage of powerful junk e-mail filters built on patented Microsoft® 
SmartScreen Technology. 
http://join.msn.com/?pgmarket=en-ca&page=byoa/prem&xAPID=1994&DI=1034&SU=http://hotmail.com/enca&HL=Market_MSNIS_Taglines 
  Start enjoying all the benefits of MSN® Premium right now and get the 
first two months FREE*.

