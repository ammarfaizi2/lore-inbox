Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbTBYTTv>; Tue, 25 Feb 2003 14:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbTBYTTv>; Tue, 25 Feb 2003 14:19:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44164 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267847AbTBYTSx>; Tue, 25 Feb 2003 14:18:53 -0500
Date: Tue, 25 Feb 2003 14:31:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: atomic_t (24 bits???)
In-Reply-To: <20030225191711.GA25331@nevyn.them.org>
Message-ID: <Pine.LNX.3.95.1030225143137.20279B-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Daniel Jacobowitz wrote:

> On Tue, Feb 25, 2003 at 02:11:11PM -0500, Richard B. Johnson wrote:
> > 
> > In ../linux/include/asm/atomic.h, for versions 2.4.18 and
> > above as far as I've checked, there are repeated warnings
> > "Note that the guaranteed useful range of an atomic_t is
> > only 24 bits."
> > 
> > I fail to see any reason why as atomic_t is typdefed to a
> > volatile int which, on ix86 seems to be 32 bits.
> > 
> > Does anybody know if this is just some old comments from a
> > previous atomic_t type of, perhaps, char[3]?  
> 
> There are other platforms where you can't reliably use the whole word. 
> Some ARM atomic_t implementations are like this, although I don't know
> if the one in the kernel is.
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> 
Okay. Thanks.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


