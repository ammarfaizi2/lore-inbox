Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314211AbSDZVZZ>; Fri, 26 Apr 2002 17:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314213AbSDZVZY>; Fri, 26 Apr 2002 17:25:24 -0400
Received: from [195.223.140.120] ([195.223.140.120]:47974 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314211AbSDZVZX>; Fri, 26 Apr 2002 17:25:23 -0400
Date: Fri, 26 Apr 2002 23:25:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Marc-Christian Petersen <mcp@linux-systeme.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.18 and strange OOM Killer behaveness
Message-ID: <20020426232541.K19278@dualathlon.random>
In-Reply-To: <200204261946.14955.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 07:46:14PM +0200, Dieter Nützel wrote:
> Marc-Christian Petersen wrote:
> 
> > Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 26038
> > (mysqld).
> > Apr 26 16:11:01 codeman kernel: Out of Memory: Killed process 3914 (pico).
> > Apr 26 16:11:01 codeman kernel: VM: killing process pico
> > Apr 26 16:11:04 codeman kernel: Out of Memory: Killed process 20471 (squid).
> >
> > So, you guess, apache, mysqld, squid and the causer pico are killed, but NO, 
> > ONLY, and i mean ONLY pico was killed, all the other Processes listed above 
> > are running fine, accepting connections, short: works fine!!
> > And yes, its reproduceable !!
> >
> > The above is a kernel without rmap!
> 
> Try with -AA (splitted vm33), latest ist 2.4.19pre7aa2.
> It works for "ages".

I second the suggestion :)

Andrea
