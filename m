Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265254AbSJRRBI>; Fri, 18 Oct 2002 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265257AbSJRQ70>; Fri, 18 Oct 2002 12:59:26 -0400
Received: from fmr04.intel.com ([143.183.121.6]:14060 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S265261AbSJRQv2>; Fri, 18 Oct 2002 12:51:28 -0400
Message-Id: <200210181656.g9IGupP31706@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Date: Fri, 18 Oct 2002 10:00:12 -0400
X-Mailer: KMail [version 1.3.1]
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <200210171958.23198.markgross@thegnar.org> <20021018035510.GA3568@nevyn.them.org>
In-Reply-To: <20021018035510.GA3568@nevyn.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 October 2002 11:55 pm, Daniel Jacobowitz wrote:
> On Thu, Oct 17, 2002 at 07:58:23PM -0700, Mark Gross wrote:
> > On Thursday 17 October 2002 07:12 pm, Andi Kleen wrote:
> > > I want the x86 CPU error code, which often has interesting clues on the
> > > problem. trapno would be useful too. I suspect other CPUs have similar
> > > extended state for exceptions.
> > >
> > > I usually hack my kernel to printk() it, but having it in the coredump
> > > would be more general and you can look at it later.
> > >
> > > Eventually (in a future kernel) I would love to have the exception
> > > handler save the last branch debugging registers of the CPU and the let
> > the > core dumper put that into the dump too.  Then you could easily >
> > figure out what the program did shortly before the crash.
> > >
> > > -Andi
> > 
> > Having the last branch before a crash would be cool.  Its easy to add
> > note sections to core files.  If it turns out to be useful I'm sure the
> > GDB folks would support it.
>
> Absolutely.  The GDB side would be pretty easy.

Sounds like fun ;)  Making it generic and extencible will be a challenge,  
for both GDB and the Linux kernel.

--mgross
