Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262173AbSITKlp>; Fri, 20 Sep 2002 06:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSITKlp>; Fri, 20 Sep 2002 06:41:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60547 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262173AbSITKlo>;
	Fri, 20 Sep 2002 06:41:44 -0400
Date: Fri, 20 Sep 2002 12:53:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <Pine.NEB.4.44.0209201144270.2586-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0209201252130.2954-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Adrian Bunk wrote:

> > Unless major flaws in the design are found this code is intended to
> > become the standard POSIX thread library on Linux system and it will
> > be included in the GNU C library distribution.
> >...
> > - - requires a kernel with the threading capabilities of Linux 2.5.36.
> >...
> 
> My personal estimation is that Debian will support kernel 2.4 in it's
> stable distribution until 2006 or 2007 (this is based on the experience
> that Debian usually supports two stable kernel series and the time
> between stable releases of Debian is > 1 year). What is the proposed way
> for distributions to deal with this?

Ulrich will give a fuller reply i guess, but the new threading code in 2.5
does not disable (or in any way obsolete) the old glibc threading library.
So by doing boot-time kernel version checks glibc can decide whether it
wants to provide the new library or the old library.

	Ingo

