Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSEOTlz>; Wed, 15 May 2002 15:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316478AbSEOTly>; Wed, 15 May 2002 15:41:54 -0400
Received: from pc132.utati.net ([216.143.22.132]:21409 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S316477AbSEOTly>; Wed, 15 May 2002 15:41:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: John Weber <john.weber@linuxhq.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Unofficial but Supported Kernel Patches
Date: Wed, 15 May 2002 09:43:26 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33L2.0205121935000.18593-100000@dragon.pdx.osdl.net> <3CDF2C7C.7090203@linuxhq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020515200758.BEAB373B@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 May 2002 11:01 pm, John Weber wrote:

> [2] Kernel Programming Documentation.  This would mostly document the
> kernel API, and important kernel data structures, as well as "good
> habits" in kernel development -- like "don't use virt_to_bus use
> blah,blah,blah".  Information like this might be useful to kernel
> janitors.  (This probably exists already).

Yeah, but filtering, collating, editing, and generally putting together a 
good, high-quality, well indexed collection never hurts.

The stuff in linux/Documentation generally seems more reference material than 
instruction material.  (Coverage is spotty and indexing is nonexistent, but 
it's way better than nothing.)  There's buildable docbook documentation in 
the source tarball that in theory could be blasted to HTML and posted online, 
and that might be nice to have a standard location for.  (If there is one 
already, I missed it.)

Try "make htmldocs" (and its cousins, make pdfdocs and make psdocs).

> [3] Necessary patches for each release.
>
> I will do any and maybe all things that folks find useful...
> other suggestions also welcome.

Actually, what I'd like to see is some kind of voting on the stability of 
releases.  (If you had users who could indicate "I currently use THIS kernel" 
and then keep a running tally of where everybody's at...

Not so much for the stable series (modulo 2.4.11) but for the -ac series, 
knowing which ones are considered relatively stable would be fun.  And 
knowing which 2.5 variants are going to at least finish booting before they 
eating your filesystem might be good. :)

Possibly you could have a version specific message board.  (Grab the 
slashcode or something and post a "story" about each new release, then 
collect them into topics.)  Linux-kernel isn't necessarily the best place for 
"comments on 2.5.15-pre-314159", because there's no real version sorting.  
We've got 2.5 development, 2.4 development, 2.5-dj, 2.4-ac, the occasional 
burp from 2.2, and all sorts of general theoretical development unrelated to 
any actual kerenel.  (Random traffic for the O(1) scheduler patches, preempt 
patches, Keith Owens' new build system, periodic CML2 flamewars...)  The 
noise level's a bit high to try to follow specific topics of interest...

Being able to thread that out a little better doesn't strike me as a bad 
thing at all...

Rob
