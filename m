Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbTCQPnz>; Mon, 17 Mar 2003 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbTCQPnz>; Mon, 17 Mar 2003 10:43:55 -0500
Received: from mail1.ugr.es ([150.214.20.24]:59295 "EHLO mail1.ugr.es")
	by vger.kernel.org with ESMTP id <S261768AbTCQPnx>;
	Mon, 17 Mar 2003 10:43:53 -0500
Subject: Re: make modules_install fail: depmod *** Unresolved symbols
	(official
From: Miguel =?ISO-8859-1?Q?Quir=F3s?= <mquiros@ugr.es>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: bonganilinux@mweb.co.za, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1047651405.3503.103.camel@workshop.saharact.lan>
References: <E18tpXR-0007oI-00@rammstein.mweb.co.za>
	 <1047651405.3503.103.camel@workshop.saharact.lan>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Universidad de Granada
Message-Id: <1047916546.1486.7.camel@migelinho.ugr.es>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 17 Mar 2003 16:55:47 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El vie, 14-03-2003 a las 15:16, Martin Schlemmer escribió:
> On Fri, 2003-03-14 at 16:03, bonganilinux@mweb.co.za wrote:
> > > 			Granada, 14-3-2002
> > > 
> > > Hello, I downloaded kernel 2.4.20 and compiled it sucessfully a month
> > > ago without any aparent problem. Yesterday I tried to compile it again
> > > in the same computer just changing a couple of small things in the
> > > configuration (agpart and the network card changed from "module" to
> > > "yes").
> > > 
> > > make dep, make bzImage and make modules went apparently well (expect for
> > > a few apparently non-important warnings with bzImage of the type
> > > Warning: indirect call without '*' when compiling pci-pc and apm).
> > > 
> > > But when I try make modules_install, I've got a lot of error messages.
> > > For each module I've got one line like:
> > > 
> > > depmod:  *** Unresolved symbols in
> > > /lib/modules/2.4.20/kernel/arch/i386/kernel/microcode.o
> > > 
> > > followed by a number of lines of the type
> > > 
> > > depmod:     misc_deregister
> > > depmod:     __generic_copy_from_use
> > > depmod:     .....
> > 
> > Download, compile and install Rusty's latest module-init-tools
> > ftp.kernel.org/pub/linux/kernel/people/rusty/modules
> > 
> 
> Errr, he got 2.4.20, not 2.5.48+ ....
> 
> Miguel:  Not a real fix, but try compiling microcode.o into the
>          kernel and not as a module ...

Thanks a lot for your answers. Well, it is not only microcode.o. It
happens for all compiled modules (at least, for a lot of them). Anyway,
I can see that all modules have been copied to /lib/modules/2.4.20 and
that the files modules.dep and modules.whatsoever have been created. A
fast look to modules.dep makes me think that this file seems to be OK.

May I use this kernel and these modules after all ignoring the depmod
errors or should I expect problems if I do so?

Thanks again.

-- 
-------------------------
Miguel Quirós Olozábal
Departamento de Química Inorgánica. Facultad de Ciencias.
Universidad de Granada. 18071 Granada (SPAIN).
email:mquiros@ugr.es

