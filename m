Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279674AbRKAUHr>; Thu, 1 Nov 2001 15:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279684AbRKAUHh>; Thu, 1 Nov 2001 15:07:37 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:20490 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S279674AbRKAUHU>; Thu, 1 Nov 2001 15:07:20 -0500
Message-Id: <200111012007.fA1K7AG10327@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Subject: Re: on exit xterm  totally wrecks linux 2.4.11 to 2.4.14-pre6 (unkillable processes)
Date: Thu, 1 Nov 2001 14:06:54 -0600
X-Mailer: KMail [version 1.3.1]
Cc: Ricardo Martins <thecrown@softhome.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3BE1777F.30705@softhome.net> <200111011945.fA1Jj0G09069@schroeder.cs.wisc.edu> <3BE1A9D5.3000508@wanadoo.fr>
In-Reply-To: <3BE1A9D5.3000508@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 14:00, Pierre Rousselet wrote:
> Nick LeRoy wrote:
> > On Thursday 01 November 2001 13:31, Pierre Rousselet wrote:
> >>Ricardo Martins wrote:
> >>> >> Procedure
> >>> >> In X windows (version 4.1.0 compiled from the sources) when writing
> >>> >> "exit" in xterm to close the terminal emulator, the window freezes,
> >>> >> and from that moment on, every process becomes "unkillable",
> >>> >> including
> >>>
> >>>xterm
> >>>
> >>> >> and X (ps also freezes), and there's no way to shutdown GNU/Linux in
> >>> >> a sane way (must hit reset or poweroff).
> >>> >
> >>> >I can see the problem here with 2.4.13. I don't know if it's kernel
> >>> >related, I'm used using rxvt, never xterm.
> >>> >
> >>> >It looks like xterm takes the terminal where you started X from.
> >>> >
> >>> >Are you using devfs ?
> >>> >
> >>> >
> >>> >Pierre
> >>>
> >>>Pierre, yes, i'm using devfs that seems to be the problem, do you know
> >>>how to fix it ?
> >>
> >>Is it devfs or xterm which needs to be fixed ? I would
> >>
> >>suggest to switch to rxvt which works fine with/without devfs.
> >
> > With all due respect, I'd have to differ.....  Do you have any idea how
> > many people are running how many copies of xterm as we speak?  Even if we
> > pair that down to all those running devfs, it's certainly a substantial
> > number. The kernel should, above all else, run old applications without
> > breaking them.
> >
> > -Nick
>
> devfs is still marked EXPERIMENTAL in the kernel building. If you select it
> you
>
> must be prepared to tolerate some misbehaviour. rxvt is not newer than
> xterm, it is lighter.

Marked experiment, for now.  What about when it's no longer "experimental"?  
Configuring a kernel to enable such a feature should *not* break 
applications, especially something as prolific as xterm.

-Nick
