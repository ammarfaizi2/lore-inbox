Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbSK2Vkk>; Fri, 29 Nov 2002 16:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSK2Vkk>; Fri, 29 Nov 2002 16:40:40 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:17080 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S267151AbSK2Vkj>; Fri, 29 Nov 2002 16:40:39 -0500
Date: Fri, 29 Nov 2002 22:48:02 +0100
From: Romain Lievin <rlievin@free.fr>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (gkc): patch & help about Makefile
Message-ID: <20021129214802.GA8225@free.fr>
References: <20021110132750.GB6256@free.fr> <Pine.LNX.4.44.0211101502460.2113-100000@serv> <20021128091059.GB388@free.fr> <Pine.LNX.4.44.0211281204030.2113-100000@serv> <20021128141223.GA601@free.fr> <Pine.LNX.4.44.0211282111110.2113-100000@serv> <20021128221239.GA1305@free.fr> <Pine.LNX.4.44.0211282318590.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211282318590.2113-100000@serv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > and if not too many people complain, it would be far easier for me to send 
> > > it on to Linus. :)
> > 
> > OK, I will send you a patch as soon as I would have finished to work on the
> > Makefile...
> 
> Please post it also to lkml, I'd really prefer to people see it and 
> comment on it. Did you have any feed back so far?
> 

Well, I have managed to successfully modify the Makefile. I separated the 2
target as you wanted to. I have written a patch for you and Sam Ravnborg.

Nevertheless, I have a small problem: I did not manage to use gcc rather than
g++ in the Makefile. This has a side effect: libglade can not connect signals
to the GUI (because it uses symbol names for doing the binding and symbol 
decoration is not the same between C & C++).
I need help for this problem.

> bye, Roman
> 
> 

Thanks, Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@lpg.ticalc.org>
Web site 			<http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"














