Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTKNJ5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTKNJ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:57:09 -0500
Received: from witte.sonytel.be ([80.88.33.193]:64174 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262315AbTKNJ5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:57:03 -0500
Date: Fri, 14 Nov 2003 10:56:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tupshin Harper <tupshin@tupshin.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FB3CB96.9080507@tupshin.com>
Message-ID: <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Tupshin Harper wrote:
> Davide Libenzi wrote:
> >Larry, if there are really six users (i'm one of them, rsync) among 
> >pserver and rsync access, I am the first to tell you shut it down. It is 
> >not worth. On the other hand IIRC it was you that, when Pavel showed up 
> >with the bitbucket hack to extract metadata from BK, volunteered to do it 
> >internally inside BM. Do I remember correctly?
> >
> As one of the six, I would happily 2nd the shutting down of the 
> pserver...rsync is fine with me. I would actually prefer no CVS archive 
> at all as long as the raw changesets were rsyncable...then the community 
> would be responsible for doing something useful with them instead of BM.

Just wondering: the emails sent to the bk-commits mailing lists are just all
changesets in a `neutral' format that contains all meta information, right?

So if all individual mails were archived somewhere with correct sequence
numbers, they could be used to recreate the whole repository in whatever format
you want. I guess it's just a matter of importing them like patches into arch.

Gr{oetje,eeting}s,

						Geert

P.S. I did use the CVS gateway before to have a base tree to verify that the
     patches I send to Linus and Marcelo still apply cleanly. But these days
     full releases are so frequent that I can use these as base trees. And I
     monitor the bk-commits lists so I know what's happening in between.
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

