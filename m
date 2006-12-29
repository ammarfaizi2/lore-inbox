Return-Path: <linux-kernel-owner+w=401wt.eu-S965117AbWL2TZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWL2TZY (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWL2TZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 14:25:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3295 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965117AbWL2TZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 14:25:23 -0500
Date: Fri, 29 Dec 2006 20:25:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Holbach <daniel.holbach@ubuntu.com>
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061229192525.GU20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org> <20061228223909.GK20714@stusta.de> <1167415630.5348.599.camel@gullible>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167415630.5348.599.camel@gullible>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 01:07:10PM -0500, Ben Collins wrote:
> On Thu, 2006-12-28 at 23:39 +0100, Adrian Bunk wrote:
> > This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you caused a breakage or I'm considering you in any other way possibly
> > involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> 
> > Subject    : i386: Oops in __find_get_block()
> > References : http://lkml.org/lkml/2006/12/16/138
> > Submitter  : Ben Collins <ben.collins@ubuntu.com>
> >              Daniel Holbach <daniel.holbach@ubuntu.com>
> > Status     : unknown
> 
> I believe this is the same bug as I've seen reported about gdb. I'd have
> to find the thread/information regarding it. Not sure if it was fixed
> already.

Subject    : BUG at fs/buffer.c:1235 when using gdb
References : http://lkml.org/lkml/2006/12/17/134
Submitter  : Andrew J. Barr <andrew.james.barr@gmail.com>
Fixed-By   : Jeremy Fitzhardinge <jeremy@goop.org>
Commit     : 8701ea957dd2a7c309e17c8dcde3a64b92d8aec0
Status     : fixed in -rc2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

