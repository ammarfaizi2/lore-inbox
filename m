Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJFW3n>; Sun, 6 Oct 2002 18:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262249AbSJFW3n>; Sun, 6 Oct 2002 18:29:43 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:43671 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262248AbSJFW2i>; Sun, 6 Oct 2002 18:28:38 -0400
Date: Sun, 6 Oct 2002 19:33:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Larry McVoy <lm@work.bitmover.com>, Nicolas Pitre <nico@cam.org>,
       Ulrich Drepper <drepper@redhat.com>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021006220300.GA9785@vitelus.com>
Message-ID: <Pine.LNX.4.44L.0210061931460.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Aaron Lehmann wrote:
> On Sat, Oct 05, 2002 at 12:54:12PM -0700, Larry McVoy wrote:
> > You can do this today.  rsync a BK tree and use GNU CSSC to check out
> > the sources.  We maintained SCCS compat for exactly that reason.
> > You've had the ability to ignore the BKL since day one if you aren't
> > running the BK binaries.
>
> Sounds great, but where can I rsync a linux bk tree from?

I just started exporting this on nl.linux.org, see
ftp://nl.linux.org/pub/linux/bk2patch/README

The following command should work:

	rsync -rav --delete nl.linux.org::kernel/linux-2.4 linux-2.4

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

