Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSEGPhT>; Tue, 7 May 2002 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315894AbSEGPhS>; Tue, 7 May 2002 11:37:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61447 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315893AbSEGPhR>; Tue, 7 May 2002 11:37:17 -0400
Date: Tue, 7 May 2002 08:36:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <5.1.0.14.2.20020507153451.02381ec0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 [ First off: any IDE-only thing that doesn't work for SCSI or other disks
   doesn't solve a generic problem, so the complaint that some generic
   tools might use it is totally invalid. ]

On Tue, 7 May 2002, Anton Altaparmakov wrote:
>
> Linux's power is exactly that it can be used on anything from a wristwatch
> to a huge server and that it is flexible about everything. You are breaking
> this flexibility for no apparent reason. (I don't accept "I can't cope with
> this so I remove it." as a reason, sorry).

Run the 57 patch, and complain if something doesn't work.

Linux's power is that we FIX stuff. That we make it the best system
possible, and that we don't just whine and argue about things.

> As the new IDE maintainer so far we have only seen you removing one
> feature after the other in the name of cleanup, without adequate or even
> any at all(!) replacements,

Who cares? Have you found _anything_ that Martin removed that was at all
worthwhile? I sure haven't.

Guys, you have to realize that the IDE layer has eight YEARS of absolute
crap in it. Seriously. It's _never_ been cleaned up before. It has stuff
so distasteful that t's scary.

Take it from me: it's a _lot_ easier to add cruft and crap on top of clean
code. You can do it yourself if you want to. You don't need a maintainer
to add barnacles.

All the information that /proc/ide gave you is basically available in
hdparm, and for your dear embedded system it apparently takes up less
space by being in user space. So what is the problem?

My vote is to remove as much as humanly possible.

	"Everything should be made as simple as possible, but not
	 simpler" - Albert Einstein

Think about it, and really _understand_ it.

			Linus

