Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbTEEOID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTEEOID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:08:03 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11751 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262231AbTEEOIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:08:02 -0400
Date: Mon, 5 May 2003 16:20:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Anders Karlsson <anders@trudheim.com>
Cc: Art Haas <ahaas@airmail.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Latest GCC-3.3 is much quieter about sign/unsigned comparisons
Message-ID: <20030505142031.GA10760@wohnheim.fh-wedel.de>
References: <20030504212256.GE24907@debian> <1052115781.25951.43.camel@marx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1052115781.25951.43.camel@marx>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 07:23:01 +0100, Anders Karlsson wrote:
> On Sun, 2003-05-04 at 22:22, Art Haas wrote:
> > This change ...
> > ... has eliminated all the warnings that GCC-3.3 by default printed
> > with regards to signed/unsigned comparisons. A build of today's BK
> > with this compiler is much quieter than those previously done
> > with the 3.3 snapshots.
> 
> Yes, it means the warnings are not printed, it doesn't mean the problem
> has gone away though.

Which one do you mean? The real signed-unsigned bugs in the kernel or
the problem of gcc to weed out the false positives.

"find /usr/src/linux -type f | xargs cat" will catch every single bug
in the linux kernel, but I bet it won't get too many fixed. Those gcc
warnings are a bit better, but just a bit.

> I'd still like for someone to tell me if there is a specific reason to
> use signed numbers in for example inode.c in one of the filesystems
> (can't remember which one of the top of my head). I for one would get
> rather surprised if some of my data started getting stored with negative
> inodes...

If you manually seperate false positives from real bugs, then those
real ones should get fixed. Feel free to bombard me with any, but try
to keep the ratio of false positives low.

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
