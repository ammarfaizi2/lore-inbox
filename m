Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267788AbUG3TIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267788AbUG3TIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267791AbUG3TIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:08:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43669 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S267788AbUG3THe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:07:34 -0400
Date: Fri, 30 Jul 2004 12:07:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: kumar.gala@freescale.com, tnt@246tNt.com, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-ID: <20040730190731.GQ16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net> <XFMail.20040729100549.pochini@shiny.it> <20040729144347.GE16468@smtp.west.cox.net> <20040730205901.4d4181f4.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730205901.4d4181f4.pochini@shiny.it>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 08:59:01PM +0200, Giuliano Pochini wrote:

> On Thu, 29 Jul 2004 07:43:47 -0700
> Tom Rini <trini@kernel.crashing.org> wrote:
> > > I had no time to do a lot of testing, but it seems that binutils 2.15 +
> > > gcc 3.3.3 is a bad one too. I didn't try to compile the kernel (which
> > > may also break), but at least I couldn't compile gcc 3.4.1 with the
> > > above combination. It seems that as doesn't get the -mxxx parameter
> > > required to compile altivec stuff. Hacking the Makefile to make it
> > > pass -Wa,-m7455 helped a little, but it eventually failed in another
> > > weird way. I hadn't time to investigate further, sorry.
> >
> > Stock gcc-3.3.3 or from the hammer branch ?
> 
> Stock.

That is interesting.  Olaf, is gcc-3.3.x + binutils-2.15 one of the
combinations you've got in your matrix of toolchains?

-- 
Tom Rini
http://gate.crashing.org/~trini/
