Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTJEVjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTJEVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:39:39 -0400
Received: from intra.cyclades.com ([64.186.161.6]:21658 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263869AbTJEVji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:39:38 -0400
Date: Sun, 5 Oct 2003 18:42:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre6
In-Reply-To: <20031002221312.GA4778@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0310051841230.7861-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Oct 2003, J.A. Magallon wrote:

> 
> On 10.01, Marcelo Tosatti wrote:
> > 
> > Hi,
> > 
> > Here goes -pre6. 
> > 
> 
> make xconfig is broken:
> 
> werewolf:/usr/src/linux-2.4.22-pre6# make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.22-pre6/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o tkparse.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
> gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> make[1]: *** [kconfig.tk] Error 139
> make[1]: Leaving directory `/usr/src/linux-2.4.22-pre6/scripts'
> make: *** [xconfig] Error 2
> 
> Any way to get more info ? Some verbose mode for tkparse ?

No idea... Mind trying to isolate the problem ? (check which -pre the 
problems started)

