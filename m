Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSBIRFx>; Sat, 9 Feb 2002 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSBIRFk>; Sat, 9 Feb 2002 12:05:40 -0500
Received: from bitmover.com ([192.132.92.2]:60554 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289026AbSBIRFa>;
	Sat, 9 Feb 2002 12:05:30 -0500
Date: Sat, 9 Feb 2002 09:05:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
        Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209090527.B13735@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020208211257.F25595@work.bitmover.com> <Pine.LNX.4.44.0202090212420.25220-100000@dlang.diginsite.com> <20020209075425.A13258@work.bitmover.com> <20020209165054.GK20094@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209165054.GK20094@opus.bloom.county>; from trini@kernel.crashing.org on Sat, Feb 09, 2002 at 09:50:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > bk clone -l
> 
> $ bk version
> BitKeeper/Free version is bk-2.1.4 20020205155016 for x86-glibc22-linux
> Built by: lm@redhat71.bitmover.com in /build/bk-2.1.x-lm/src
> Built on: Tue Feb  5 08:01:19 PST 2002
> $ bk clone -l
> usage:  bk clone [-ql] [-E<env>=<val>] [-r<rev>] [-z[<d>]] <from> [<to>]

Tom, I can't believe you are running that ancient version of BK, why it is
already 4 days old!  Try and stay current :-)

There is a 2.1.4b release that has clone -l in it, along with some rollup
fixes/enhancements for Linus.

There is an undocumented version of clone -l in your release which works like

	bk lclone from to

and does the hardlinks.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
