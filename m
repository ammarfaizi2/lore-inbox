Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314559AbSEBPWs>; Thu, 2 May 2002 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSEBPWq>; Thu, 2 May 2002 11:22:46 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:11004 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S314560AbSEBPV7>; Thu, 2 May 2002 11:21:59 -0400
Message-ID: <3CD15996.8EB1699F@redhat.com>
Date: Thu, 02 May 2002 16:21:58 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.24smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173HX6-00041D-00@the-village.bc.nu> <3CD13FF3.5020406@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Uz.ytkownik Alan Cox napisa?:
> >>>change configs, rebuild without make mrproper).  To do modversions
> >>>right needs a new version of modutils as well, there is no chance of
> >>>that work being started until kbuild 2.5 is in the kernel.
> >>
> >>How many years was it that I was telling that symbol versioning is
> >>a silly concept not solving any single problem and the implementation is to say
> >>the least ugly?
> >
> >
> > Modversions solves a huge number of problems very very well. The fact that
> > you don't like it doesn't change the reality of the situation.
> 
> Could you name *ONE* please? Maybe the following?

It fixes the problem where support people and people who get the
bugreports have
to stare at "impossible" problems for hours and hours to find out that
someone
has insmod'ed a module for a different kernel (be it an athlon module in
a i686 kernel
or someone using perl to replace the built-in kernel version in the .o
file)
