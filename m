Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317750AbSFSC4M>; Tue, 18 Jun 2002 22:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSFSC4M>; Tue, 18 Jun 2002 22:56:12 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:65496 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317750AbSFSC4L>; Tue, 18 Jun 2002 22:56:11 -0400
Date: Tue, 18 Jun 2002 21:56:11 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, <sam@ravnborg.org>
Subject: Re: Various kbuild problems in 2.5.22
In-Reply-To: <200206190250.TAA09390@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0206182154330.5695-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Adam J. Richter wrote:

> >Well, let's say I agree that the kind of semantics change regarding
> >building modules at the same time isn't the nicest. So I propose the
> >following:
> 
> >make bzImage -> compile built-in, build bzImage
> >make modules -> compile modules
> >make bzImage modules -> build bzImage + modules (I found a way to do so
> >                        without having to descend twice)
> 
> >make,
> >make all     -> compile vmlinux + modules as a general default,
> >                on i386 build bzImage + modules.
> >               (other archs can change the behavior as they wish)
> 
>         Great.  That's fine with me.

Okay. This (and some of the other small fixes, like 53c700 modversions 
generation) didn't make it into 2.5.23, but should be in the next release 
- couldn't keep up with Linus' pace ;)

--Kai


