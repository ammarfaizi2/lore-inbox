Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279796AbRKAV37>; Thu, 1 Nov 2001 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279795AbRKAV3t>; Thu, 1 Nov 2001 16:29:49 -0500
Received: from kaboom.dsl.xmission.com ([166.70.14.108]:4210 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S279784AbRKAV3b>;
	Thu, 1 Nov 2001 16:29:31 -0500
Date: Thu, 1 Nov 2001 14:29:25 -0700 (MST)
From: Chris Ricker <kaboom@gatech.edu>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Danek Duvall <duvall@emufarm.org>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: Code from ~2.4.4 going into Solaris 9 Alpha?
In-Reply-To: <20011101131050.B766@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0111011423510.20119-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Mike Fedyk wrote:

> On Thu, Nov 01, 2001 at 11:53:19AM -0800, Danek Duvall wrote:
> > On Thu, Nov 01, 2001 at 11:15:08AM -0800, Mike Fedyk wrote:
> > 
> > > I just looked at http://perso.wanadoo.fr/levenez/unix/history.html, and
> > > noticed a line from linux over to solaris 9 alpha.
> > >
> > > Does anyone know what code they copied, and if they're now making 
> > > solaris GPL compatible?

<snip>

Solaris 9/ia32 includes software called lxrun (actually slip-streamed during
Solaris 8, as Sun is so fond of doing for some brain-dead reason) which
implements the Linux/ia32 ABI on Solaris/ia32.  It's much like the Linux
compatibility layer all the *BSDs have these days.

Solaris 9 on both Intel and Sparc also implements more of the Linux (really
primarily GNU glibc) APIs.  The idea is that Linux apps are now just a
recompile away from running on Solaris (assuming they're sane and don't have
32-bit / 64-bit or endian issues to be sorted out), with no portage 
necessary....

I'd imagine these two features are what the line reflects.  No code theft 
has taken place, and Solaris is definitely not GPL'ed.

later,
chris

