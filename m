Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266151AbUFUICf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266151AbUFUICf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUFUICe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:02:34 -0400
Received: from [195.255.196.126] ([195.255.196.126]:27622 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S266151AbUFUIC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:02:26 -0400
Date: Mon, 21 Jun 2004 11:02:25 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Dev Mazumdar <dev@opensound.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
In-Reply-To: <20040621064700.GA19511@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406211101030.26608@zeus.compusonic.fi>
References: <20040620211905.GA10189@mars.ravnborg.org>
 <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org>
 <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
 <20040621064700.GA19511@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Arjan van de Ven wrote:

> On Mon, Jun 21, 2004 at 03:29:24AM +0300, Hannu Savolainen wrote:
> > Does something like the following sound good?
> >
> > sh /lib/modules/`uname -r`/build/make_module $MYSUBDIR CC=$CC
>
>
> no you shold not override the compiler; the makefiles should do that instead
> automatically
Right. That would be better.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
