Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFCMnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFCMnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 08:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFCMno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 08:43:44 -0400
Received: from witte.sonytel.be ([80.88.33.193]:28369 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261245AbVFCMnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 08:43:43 -0400
Date: Fri, 3 Jun 2005 14:43:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Schwab <schwab@suse.de>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       XIAO Gang <xiao@unice.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on "int len" sanity
In-Reply-To: <jer7fjeiae.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.62.0506031443000.16362@numbat.sonytel.be>
References: <429EB537.4060305@unice.fr> <20050602084840.GA32519@wohnheim.fh-wedel.de>
 <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be> <jer7fjeiae.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2005, Andreas Schwab wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> >> 	union {
> >> 		unsigned len;
> >                 ^^^^^^^^
> > Plain unsigned is deprecated.
> 
> Says who?

Sorry, forgot to add the
`Signed-Off-by: Geert Uytterhoeven <geert@linux-m68k.org>' line :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
