Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUCWLLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUCWLLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:11:35 -0500
Received: from dialpool3-198.dial.tijd.com ([62.112.12.198]:34945 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262485AbUCWLLS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:11:18 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Tue, 23 Mar 2004 12:11:00 +0100
User-Agent: KMail/1.6.1
Cc: Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <20040320174956.GA3177@dreamland.darkstar.lan> <1079909446.911.165.camel@gaston> <20040322195720.GA27480@kroah.com>
In-Reply-To: <20040322195720.GA27480@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403231211.09334.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 22 March 2004 20:57, Greg KH wrote:
> On Mon, Mar 22, 2004 at 09:50:46AM +1100, Benjamin Herrenschmidt wrote:
> > > I prefere graphics myself. Display sounds to generic. That is what
> > > video and graphics output is piped to. Since fbdev doesn't handle video
> > > ouput normally this is kind of fuzzy sounding.
> >
> > I still prefer display...
>
> Bah, I don't want to argue here.  I've applied Kronos's patch as is to
> my device-2.6 tree which will end up in the next -mm release.
>
> I'll hold off forwarding this patch to Linus until after 2.6.5 is out,
> so that gives everyone a few days in which to argue the name a bunch and
> then send me a patch that changes it to the decided apon name (if it is
> to be changed.)

- From a users point of view: if there are only to be framebuffer devices listed 
in this class, why not call it just what it is: "Framebuffer" ? Naming it 
after something it is only in a broad sense makes no sense to me. I'd be 
looking in /sys/.../framebuffer instead of /sys/.../graphics or /display.

Display would be the EDID info of my screen (physical), and graphics... 
well... I'd half expect something like capture cards to be there...

Just my 0.02EUR.

Jan

- -- 
patent:
	A method of publicizing inventions so others can copy them.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYBtMUQQOfidJUwQRAugBAJ4jSuhjpzr2jySPGmc6yk4lYflILgCfTB0M
nA8OHiWcRfjRllgoxC/KJBY=
=I8ag
-----END PGP SIGNATURE-----
