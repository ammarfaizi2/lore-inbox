Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278177AbRKAH1t>; Thu, 1 Nov 2001 02:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278214AbRKAH1j>; Thu, 1 Nov 2001 02:27:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:928 "EHLO twilight.cs.hut.fi")
	by vger.kernel.org with ESMTP id <S278177AbRKAH1a>;
	Thu, 1 Nov 2001 02:27:30 -0500
Date: Thu, 1 Nov 2001 09:27:10 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Doug McNaught <doug@wireboard.com>
Cc: Riley Williams <rhw@MemAlpha.cx>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
Message-ID: <20011101092709.I1504@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX> <m31yjjz6ws.fsf@belphigor.mcnaught.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m31yjjz6ws.fsf@belphigor.mcnaught.org>; from doug@wireboard.com on Wed, Oct 31, 2001 at 07:11:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 07:11:47PM -0500, you [Doug McNaught] claimed:
> Riley Williams <rhw@MemAlpha.cx> writes:
> 
> The Bourne shell is more perverse than you realize:
> 
> $ exec 3>&1; find / -name "wanted-but-lost-download" 2>&1 1>&3 3>&- | eat
> 
> [stolen from "Csh Programming Considered Harmful" by Tom Christiansen]

Wow. I actually played a minute with zsh, but didn't find a way... I was
pretty sure, though, that it was doable.
 
> Horrible, but does work.  ;) 
> 
> > > zerofill | head -c 1440k > /tmp/floppy.img
> > 
> > How does zerofill know when to stop writing zeros out?
> 
> Easy, it gets EPIPE on the write (or gets killed by SIGPIPE if it's
> stupid). 

Stupid... Or lazy ;).
 
> > > ssh foo@bar | block
> > 
> > Which of my examples is this an equivalent to? I don't recognise it.
> 
> None; he's referring to the /dev/block example that started the
> thread.

Yep.

> I'm still happy to keep /dev/null and /dev/zero.  ;)

So am I. Perhaps it is better to let this thread die...


-- v --

v@iki.fi
