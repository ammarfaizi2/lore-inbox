Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262878AbSJRDtD>; Thu, 17 Oct 2002 23:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJRDtD>; Thu, 17 Oct 2002 23:49:03 -0400
Received: from crack.them.org ([65.125.64.184]:20492 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262878AbSJRDtB>;
	Thu, 17 Oct 2002 23:49:01 -0400
Date: Thu, 17 Oct 2002 23:55:10 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021018035510.GA3568@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <200210171835.21647.markgross@thegnar.org> <20021018021242.GA15853@averell> <200210171958.23198.markgross@thegnar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210171958.23198.markgross@thegnar.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 07:58:23PM -0700, Mark Gross wrote:
> On Thursday 17 October 2002 07:12 pm, Andi Kleen wrote:
> > I want the x86 CPU error code, which often has interesting clues on the
> > problem. trapno would be useful too. I suspect other CPUs have similar
> > extended state for exceptions.
> >
> > I usually hack my kernel to printk() it, but having it in the coredump
> > would be more general and you can look at it later.
> >
> > Eventually (in a future kernel) I would love to have the exception
> > handler save the last branch debugging registers of the CPU and the let the
> > core dumper put that into the dump too.  Then you could easily
> > figure out what the program did shortly before the crash.
> >
> > -Andi
> 
> Having the last branch before a crash would be cool.  Its easy to add note 
> sections to core files.  If it turns out to be useful I'm sure the GDB folks 
> would support it. 

Absolutely.  The GDB side would be pretty easy.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
