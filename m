Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBJEPF>; Sat, 9 Feb 2002 23:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSBJEOx>; Sat, 9 Feb 2002 23:14:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289255AbSBJEOm>; Sat, 9 Feb 2002 23:14:42 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [bk patch] Make cardbus compile in -pre4
Date: Sun, 10 Feb 2002 04:13:33 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a44s1d$7o8$1@penguin.transmeta.com>
In-Reply-To: <20020209090527.B13735@work.bitmover.com> <20020209134132.J13735@work.bitmover.com> <20020209163603.B9826@lynx.turbolabs.com> <20020209155258.E18734@work.bitmover.com>
X-Trace: palladium.transmeta.com 1013314474 20477 127.0.0.1 (10 Feb 2002 04:14:34 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Feb 2002 04:14:34 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020209155258.E18734@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>
>This is because the dependencies are incorrect in the makefiles.  If you
>have correct dependencies in the makefiles, make will do the right thing.

Modulo bugs.

For some reason, on my work machine, "make" will not correctly check out
files that are "include"d from the makefile.

On my home machine, it will.

The really interesting thing is, they're both make 3.79.1.

Besides, I'd at least personally rather do "bk -r get -q" than have to
watch those SCCS files and BitKeeper files. That way the filename
completion works inside the shell too..

			Linus
