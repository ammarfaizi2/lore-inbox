Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTBFWFj>; Thu, 6 Feb 2003 17:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTBFWFj>; Thu, 6 Feb 2003 17:05:39 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:61592 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S267491AbTBFWFi>; Thu, 6 Feb 2003 17:05:38 -0500
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302061300430.7389-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302061300430.7389-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 06 Feb 2003 15:12:31 -0700
Message-Id: <1044569551.14310.311.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 14:02, Linus Torvalds wrote:
> 
> On 6 Feb 2003, Steven Cole wrote:
> > 
> > In this case the issue is not a broken mailer, but rather the improper
> > use of a good one.  Mark is using Evolution and so am I.  It appears
> > that he did a cut and paste from an xterm (or something similar) which
> > converted the tabs to spaces.
> 
> Ahh, yes. That would also do it.
> 
> [ I'm also happy to hear that Evolution does it right these days, I have
>   this memory of it pruning whitespace at ends of lines by default like
>   some broken versions of pine also did. But maybe it was some other
>   graphical mail client. ]
> 
> Anyway, applied.
> 
> 		Linus

BTW, to save bandwidth and whitespace mishaps we could send patches as
scripts, just like Al Viro did once-upon-a-time.
http://marc.theaimsgroup.com/?l=linux-kernel&m=102669188302509&w=2

So, since this uses ex instead of vi ;), here is something to fix
the spelling of definite and separate throughout the tree.

Applied to plain 2.5.59, diffstat reports this for the 871-line diff:
63 files changed, 77 insertions(+), 77 deletions(-)

Steven

#!/bin/sh
find . -name "*" | xargs grep -l definat | awk '{print "ex - ",$1," -c \"%s/definat/definit/g|x\""}' | sh
find . -name "*" | xargs grep -l seperat | awk '{print "ex - ",$1," -c \"%s/seperat/separat/g|x\""}' | sh





