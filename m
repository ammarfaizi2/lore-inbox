Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTEFL5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTEFL5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:57:47 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:7114 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262620AbTEFL5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:57:17 -0400
Date: Tue, 6 May 2003 14:09:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030506120939.GB15261@wohnheim.fh-wedel.de>
References: <20030505210811.GC7049@wohnheim.fh-wedel.de> <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1052218090.28792.15.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 11:48:11 +0100, Alan Cox wrote:
> On Llu, 2003-05-05 at 22:08, Jörn Engel wrote:
> > 
> > This patch makes a lot of sense in my eyes, but maybe someone
> > disagrees. Applies cleanly to current 2.4.
> > 
> > Comments?
> 
> MSDOS partitions turn up in lots of places beyond x86 boxes. The
> port maintainers made their decisions for sound reasons

Which were?

My reasons for this patch:

- Even if x86 is not the only platform that uses MSDOS partitions,
this should be a positive list, not a negative list. Else every new
platform has to explicitly express, *not* to use MSDOS partitions.
Seems awkward.

- Any platform needing MSDOS partitions but not explicitly listed can
still turn that option on through the advanced partitioning.
Currently, allnoconfig gives you MSDOS partitioning, which is not very
intuitive.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
