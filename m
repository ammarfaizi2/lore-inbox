Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSDCLc1>; Wed, 3 Apr 2002 06:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSDCLcS>; Wed, 3 Apr 2002 06:32:18 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:23778 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S311206AbSDCLcI>; Wed, 3 Apr 2002 06:32:08 -0500
Message-Id: <200204031132.g33BW5M28288@fubini.pci.uni-heidelberg.de>
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: Re: time jumps
Date: Wed, 3 Apr 2002 13:32:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203271729290.15451-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after changing from 'CONFIG_X86_TSC=n' to 'CONFIG_X86_TSC=y' the problem 
still exists, so I'm going to try some other suggestions.

But nevertheless, thanks for your help,

Bernd

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
