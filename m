Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTDNOfx (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTDNOfx (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:35:53 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:18364 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263300AbTDNOfw (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 10:35:52 -0400
Date: Mon, 14 Apr 2003 16:47:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: James Bourne <jbourne@hardrock.org>, Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414144709.GE10347@wohnheim.fh-wedel.de>
References: <200304121154.32997.m.c.p@wolk-project.de> <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org> <20030414134603.GB10347@wohnheim.fh-wedel.de> <1050330667.4059.27.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1050330667.4059.27.camel@workshop.saharact.lan>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 16:31:08 +0200, Martin Schlemmer wrote:
> On Mon, 2003-04-14 at 15:46, Jörn Engel wrote:
> 
> > Privately, I have introduced a variable FIXLEVEL for this. The
> > resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> > is more suiting for a fixed stable kernel.
> 
> This is not a good idea ... especially if its a box that you
> compile a lot of software on.  Reason is that everything expects
> it to be MAJ.MIN.MIC  ... If you add now another version, then
> things start to break.  A good example is mozilla ...

That doesn't convince me (yet?). Why doesn't 2.4.20-pre5-ac3 break
mozilla, but 2.4.20.1 does? If mozilla depends on this information, it
should at least have a robust parser for it.

Can you give me a little more details on this? Did anyone ever declare
that userspace can expect kernel versions to fit this regex?
\d+\.\d+\.\d+(-.+)?

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
