Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUJZLN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUJZLN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUJZLN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:13:28 -0400
Received: from witte.sonytel.be ([80.88.33.193]:46286 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262227AbUJZLMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:12:43 -0400
Date: Tue, 26 Oct 2004 13:12:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
In-Reply-To: <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
 <20041025232654.GC30574@thundrix.ch> <clkrak$rtl$1@terminus.zytor.com>
 <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Denis Vlasenko wrote:
> On Tuesday 26 October 2004 09:37, H. Peter Anvin wrote:
> > Followup to:  <20041025232654.GC30574@thundrix.ch>
> > By author:    Tonnerre <tonnerre@thundrix.ch>
> > In newsgroup: linux.dev.kernel
> > > On Sun, Oct 24, 2004 at 03:33:33PM +0200, Helge Hafting wrote:
> > > > Yes - lets stick to fewer numbers.  They can count faster, instead
> > > > of having a long string of them.  I hope linux doesn't
> > > > end up like X. "X11R6.8.1" The "X" itself is a counter, although
> > > > it is understandable if it never increments to "Y".  But
> > > > that "11" doesn't change much, and then there are three more numbers. :-/
> > > X11  is the  name of  the  protocol: the  X Protocol,  version 11,  as
> > > released by the MIT. There was an X10.
> > 
> > There also were a W, and and X1, X2, ... X11.
> > 
> > However, there is a tendency for numbers to get stuck (witness Linux
> > 2.x).  In particular, X11R6 got encoded in many places including
> > pathnames for no good reason.  Under the pre-R6 naming schemes we'd
> > had R7 a long time ago.
> 
> How true.

> This should be removed.
> 
> cd /usr/lib; ln -s /usr/X11R6/* .
> 	or
> echo /usr/X11R6/lib >>/etc/ld.so.conf
> 
> are the better ways to handle this
> (I use first one)

/usr/{bin,lib/X11 have been version-free symlinks since ages...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
