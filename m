Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSALT0J>; Sat, 12 Jan 2002 14:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287342AbSALT0C>; Sat, 12 Jan 2002 14:26:02 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:35846 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S287359AbSALTZq>;
	Sat, 12 Jan 2002 14:25:46 -0500
Date: Sat, 12 Jan 2002 12:23:07 -0700
From: yodaiken@fsmlabs.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Rob Landley <landley@trommello.org>,
        Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112122307.A6034@hq.fsmlabs.com>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com> <3C4076EC.FEA42077@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C4076EC.FEA42077@linux-m68k.org>; from zippel@linux-m68k.org on Sat, Jan 12, 2002 at 06:48:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 06:48:28PM +0100, Roman Zippel wrote:
> Hi,
> 
> yodaiken@fsmlabs.com wrote:
> 
> > No. The point of using semaphores is that one can sleep while
> > _waiting_ for the resource.
> > [...]
> > In a preemptive kernel this can cause a deadlock. In a non
> > preemptive it cannot. You are correct in that
> > B:
> >         get sem on memory pool
> >                 do potentially blocking operations
> >         release sem
> > is also dangerous - but I don't think that helps your case.
> > To fix B, we can enforce a coding rule - one of the reasons why
> > we have all those atomic ops in the kernel is to be able to
> > avoid this problem.
> 
> Sorry I can't follow you. First, one can sleep while waiting for the

We're having a write only discussion - time to stop.

