Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSH1SyK>; Wed, 28 Aug 2002 14:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSH1SyK>; Wed, 28 Aug 2002 14:54:10 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:14489 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318813AbSH1SyJ>; Wed, 28 Aug 2002 14:54:09 -0400
Date: Wed, 28 Aug 2002 11:52:32 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Kai-Boris Schad <kschad@ebs.e-technik.uni-ulm.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Q: Howto access the keyboard in a linux system without a graphics
 card ?
In-Reply-To: <200208260943.LAA25845@correo.e-technik.uni-ulm.de>
Message-ID: <Pine.LNX.4.33.0208281151380.1459-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its is easy if your keyboard driver is based on the input api. Just use
the /dev/input/event interface.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Mon, 26 Aug 2002, Kai-Boris Schad wrote:

> Hi !
>
> I'm trying to set up a small embedded system for gps receiving with a linux
> system.  I want to have the system working without a graphics card - wich
> works well. The Problem I have at the moment is to access the keyboard
> without a graphics card, because the console driver does not start then (
> Also a redirect doesn't work then :-( )
> Is there a way to access the keyboard in this case by a user program ?
> The system recognises the keyboard ( I think Kernel and init) and reacts if
> ctrl-alt-del is pressed.
>
> Thanks for your help !
>
> Kai
>
> --
> Kai-Boris Schad
> University of Ulm, Germany
> Dept. of Electron Devices and Circuits
> Integrated Circuits in Communications
> Albert Einstein Allee 45
> 89069 ULM
>
> http://www.uni-ulm.de/icic
> email:kschad@ebs.e-technik.uni-ulm.de
> phone +49/731/50-31581  fax +49/731/50-31599
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

