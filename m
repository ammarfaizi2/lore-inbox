Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbTCNOI3>; Fri, 14 Mar 2003 09:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbTCNOI3>; Fri, 14 Mar 2003 09:08:29 -0500
Received: from [196.41.29.142] ([196.41.29.142]:37623 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S263317AbTCNOI1>; Fri, 14 Mar 2003 09:08:27 -0500
Subject: Re: make modules_install fail: depmod *** Unresolved symbols
	(official
From: Martin Schlemmer <azarah@gentoo.org>
To: bonganilinux@mweb.co.za
Cc: Miguel =?ISO-8859-1?Q?Quir=F3s?= <mquiros@ugr.es>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <E18tpXR-0007oI-00@rammstein.mweb.co.za>
References: <E18tpXR-0007oI-00@rammstein.mweb.co.za>
Content-Type: text/plain
Organization: 
Message-Id: <1047651405.3503.103.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 14 Mar 2003 16:16:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 16:03, bonganilinux@mweb.co.za wrote:
> > 			Granada, 14-3-2002
> > 
> > Hello, I downloaded kernel 2.4.20 and compiled it sucessfully a month
> > ago without any aparent problem. Yesterday I tried to compile it again
> > in the same computer just changing a couple of small things in the
> > configuration (agpart and the network card changed from "module" to
> > "yes").
> > 
> > make dep, make bzImage and make modules went apparently well (expect for
> > a few apparently non-important warnings with bzImage of the type
> > Warning: indirect call without '*' when compiling pci-pc and apm).
> > 
> > But when I try make modules_install, I've got a lot of error messages.
> > For each module I've got one line like:
> > 
> > depmod:  *** Unresolved symbols in
> > /lib/modules/2.4.20/kernel/arch/i386/kernel/microcode.o
> > 
> > followed by a number of lines of the type
> > 
> > depmod:     misc_deregister
> > depmod:     __generic_copy_from_use
> > depmod:     .....
> 
> Download, compile and install Rusty's latest module-init-tools
> ftp.kernel.org/pub/linux/kernel/people/rusty/modules
> 

Errr, he got 2.4.20, not 2.5.48+ ....

Miguel:  Not a real fix, but try compiling microcode.o into the
         kernel and not as a module ...


Regards,

-- 
Martin Schlemmer
Gentoo Linux Developer, Desktop Team
Cape Town, South Africa

