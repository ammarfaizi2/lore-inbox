Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTGHOgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTGHOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:36:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263285AbTGHOgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:36:20 -0400
Date: Tue, 8 Jul 2003 07:49:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: root@chaos.analogic.com
Cc: jamie@shareable.org, linux-kernel@vger.kernel.org
Subject: Re: syscall __NR_mmap2
Message-Id: <20030708074919.4d5db00d.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0307081033190.267@chaos>
References: <Pine.LNX.4.53.0307071655470.22074@chaos>
	<20030708003656.GC12127@mail.jlokier.co.uk>
	<Pine.LNX.4.53.0307080749160.24488@chaos>
	<20030708140546.GA15612@mail.jlokier.co.uk>
	<Pine.LNX.4.53.0307081033190.267@chaos>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 10:40:15 -0400 (EDT) "Richard B. Johnson" <root@chaos.analogic.com> wrote:

| On Tue, 8 Jul 2003, Jamie Lokier wrote:
| 
| > Richard B. Johnson wrote:
| > > > The offset argument to mmap2 is divided by PAGE_SIZE.
| > > > That is the whole point of mmap2 :)
| > >
| > > Okay. Do you know where that's documented? Nothing in linux/Documentation,
| > > and nothing in any headers. Do you have to read the code to find out?
| > >
| > > So, the address is now the offset in PAGES, not bytes. Seems logical,
| > > but there is no clue in any documentation.
| >
| > I found this great command which really helps.  Only 1337 kernel
| > gnurus know about it, now u can be 1 2 :)
| >
| > $ man mmap2
| > [...]
| >        The  function mmap2 operates in exactly the same way as mmap(2), except
| >        that the final argument specifies the offset into the file in units  of
| >        the  system  page  size  (instead of bytes).
| >
| > -- Jamie
| >
| 
| Yeah? So the Linux kernel now requires a specific vendor distribution?
| Since when?
| 
| So, to get the proper documentation of the Linux Kernel, I now
| need to purchase a vendor's distribution??? I think not. I think
| the sys-calls need to be documented and I think that I have established
| proof of that supposition.

I can read that mmap2 man page by downloading the latest tarball
from http://www.kernel.org/pub/linux/docs/manpages/ ,
regardless of my distro.

And if what you want/need isn't there, aeb accepts contributions
to it as well.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
