Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTBCXd3>; Mon, 3 Feb 2003 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBCXd3>; Mon, 3 Feb 2003 18:33:29 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:56000 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266939AbTBCXd2>;
	Mon, 3 Feb 2003 18:33:28 -0500
Date: Mon, 3 Feb 2003 15:17:40 -0800
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: 32bit emulation of wireless ioctls
Message-ID: <20030203231740.GA29267@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030203214325.GA28330@bougret.hpl.hp.com> <20030203224619.GA6405@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203224619.GA6405@wotan.suse.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 11:46:19PM +0100, Andi Kleen wrote:
> 
> > 	Anyway, I believe that 64 bit platforms will need to become
> > mainstream before the issue of wireless on 64 bit is pressing, and by
> > that time most distro will have made the jump.
> 
> Hmm, not so sure. I guess people will sooner than later plug wireless
> cards into 64bit boxes, especially with x86-64 which will hopefully
> be quite "mainstream".

	But I content that when it is that much mainstream, you will
have 64 bit distros.

> > > That is currently done (-EINVAL), but the emulation layer logs an 
> > > warning.
> > 
> > 	It's just a shame that it's not more distinctive, because the
> > error message wouldn't lead me to think "doh, I need a recompile".
> 
> Do you have a better suggestion?

	I checked the errno list, and there was not one obvious
candidate. Potentially we could abuse ENOEXEC, but I must admit my
knowledge of errnos is too superficial.

> Anyways: for me it is just slightly annoying to not have 32bit 
> emulation for something, but for other ports like sparc64/ppc64/mips64 
> it can be show stopper because they only have 32bit userland.

	<Puzzled of why you would *not* want a 64 bit userland>

> Expect trouble when DaveM wants to plug a wireless card into one of 
> his sparc64 boxes ;-)

	I want to see that ;-)
	I've always been telling David and Stephane here that they
should loan me an Itanium box to make sure IrDA and Wireless LAN work
properly, for the day we will release a PDA with an Itanium processor.

> -Andi

	Have fun...

	Jean
