Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSE2Xvd>; Wed, 29 May 2002 19:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSE2Xvd>; Wed, 29 May 2002 19:51:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14069 "EHLO branoic")
	by vger.kernel.org with ESMTP id <S315784AbSE2Xvb>;
	Wed, 29 May 2002 19:51:31 -0400
Date: Wed, 29 May 2002 19:51:16 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: frank.schafer@setuza.cz, linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <20020529235116.GB3797@branoic.them.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	frank.schafer@setuza.cz, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu> <20020519.214053.19164382.davem@redhat.com> <1021876190.250.7.camel@ADMIN> <20020520.141800.52934272.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 02:18:00PM -0700, David S. Miller wrote:
>    From: Frank Schaefer <frank.schafer@setuza.cz>
>    Date: 20 May 2002 08:29:50 +0200
> 
>    On Mon, 2002-05-20 at 06:40, David S. Miller wrote:
>    > Only Sparc implements this, that is correct.
>    
>    ... and that's the reason why GDB don't support follow-fork-mode for the
>    intel pltform - right? ( I had a related thread on the gdb mailing list
>    not soo long ago. )
> 
> I can't see any reason why lack of PTRACE_READDATA prevents follow
> fork mode support in GDB.

It doesn't.  Follow-fork support is possible now, with a speed hit, but
I am waiting for better kernel support; it should be forthcoming with
the task ornament-based debugging interface proposed some time ago.

>  But then again the GDB maintainers are a
> bunch of pinheads so...

Hey, I resemble this remark.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
