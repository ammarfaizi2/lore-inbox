Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSC0SXo>; Wed, 27 Mar 2002 13:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313063AbSC0SXe>; Wed, 27 Mar 2002 13:23:34 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:21681 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S313062AbSC0SX0>; Wed, 27 Mar 2002 13:23:26 -0500
Message-Id: <200203271823.g2RINIM11972@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: Re: time jumps
Date: Wed, 27 Mar 2002 19:23:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203271729290.15451-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 March 2002 18:33, Mark Cooke wrote:
> There is a hardware bug on some via 686a systems where the RTC appears
> automagically change it's programmed value.
>
> A patch was originally made against 2.4.2, and some version of this
> appears to be applied to current kernels (I don't have a vanilla
> 2.4.17 to check against).  Look in arch/i386/kernel/time.c for mention
> of 686a.
>
> It appears to only be used if the kernel's not compiled with
> CONFIG_X86_TSC though, so if you have that defined you may not see the
> problem at all...
>
> Mark
>


Ah, thank you very much. I'll try this first.

Thanks, Bernd
