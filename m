Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSKNRnD>; Thu, 14 Nov 2002 12:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSKNRnD>; Thu, 14 Nov 2002 12:43:03 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:34437
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265108AbSKNRnC>; Thu, 14 Nov 2002 12:43:02 -0500
Date: Thu, 14 Nov 2002 12:47:49 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Andreas Steinmetz <ast@domdv.de>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021114174246.GB10723@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211141247180.1073-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Sam Ravnborg wrote:

> On Thu, Nov 14, 2002 at 09:35:53AM -0600, Kai Germaschewski wrote:
> > I think there's good reasons for both distclean and mrproper, distclean is
> > the standard target which most projects use, and mrproper is the
> > traditional Linux kernel target. So I would vote for keeping them both
> > (and share a common help entry).
> > 
> > What I don't see is why we would need different semantics, though, 
> > anybody?
> How about the following:
> clean	Delete all intermidiate files, including symlinks and modversions
> mrproper	clean + deletes .config and .config.old
> distclean	mrproper + all editor backup, patch backup files

Looks sensible to me.


Nicolas

