Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbUJYRMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbUJYRMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJYRJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:09:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:33928 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261153AbUJYRJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:09:15 -0400
Date: Mon, 25 Oct 2004 19:04:01 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Andi Kleen <ak@suse.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 13/17] 4level support for sh
Message-ID: <20041025170401.GB9142@wotan.suse.de>
References: <417CAA06.mail3ZK11VJ7Y@wotan.suse.de> <20041025082232.GA1419@linux-sh.org> <20041025160959.GB26306@verdi.suse.de> <20041025162510.GB9937@linux-sh.org> <20041025163211.GI25154@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025163211.GI25154@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:32:11AM -0700, Tom Rini wrote:
> On Mon, Oct 25, 2004 at 07:25:10PM +0300, Paul Mundt wrote:
> > On Mon, Oct 25, 2004 at 06:09:59PM +0200, Andi Kleen wrote:
> > > BTW separate objdir build seems to be totally broken on sh and 
> > > it adds random bogus symlinks to the source tree when you do 
> > > that. Perhaps you can fix that too.
> > > 
> > Tom Rini was working on that stuff, I've not tested it myself. I thought
> > this was all fixed by now though, Tom?
> 
> The last problem with SH and O= I found was with EMBEDDED_RAMDISK.
> Andi, can you be more specific about bogus symlinks ?  Unless I broke
> something when copying from ARM, it shouldn't have any more, or less,
> problems than ARM for include/asm/foo symlinks.

I tried a separate objdir compilation which eventually didn't work.
But my original source tree had several symlinks and a machtypes.h file 
now in include/asm-sh*/* which messed up diffs.

-Andi
