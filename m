Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRJSWAh>; Fri, 19 Oct 2001 18:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278678AbRJSWA2>; Fri, 19 Oct 2001 18:00:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10150 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278675AbRJSWAL>;
	Fri, 19 Oct 2001 18:00:11 -0400
Date: Fri, 19 Oct 2001 18:00:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <Pine.LNX.3.96.1011019233051.456A-100000@mickey.hamnixda.de>
Message-ID: <Pine.GSO.4.21.0110191743220.25190-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Oct 2001, Richard Guenther wrote:

> > Or, say it, one about meaning of
> >         if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {
> > not being the same as
> >         if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {
> 
> Err, who said that it is the same?? Its sufficient, if you trust
> root to just pass '0' or '1'. Ok, its probably too clever for the
> average C programmer, but it seems I didnt care.

	If you trust root to pass '0' or '1' - (count == 1) would do nicely.
And sorry, but "clever" is not the word that comes to mind.  "Not having a
clue on the meaning of bitwise operations" would be more accurate.

> > As for the version in -ac and maintaining it - sure I will.
> 
> Just get Linus to take the -ac version then. I'm sick to read

<shrug> might be a good idea.  The thing is extremely sloppy and considering
the blatant "I'm t00 l33t t0 F1X 7h4t" attitude of maintainer...

