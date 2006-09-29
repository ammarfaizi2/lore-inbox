Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWI2Tka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWI2Tka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWI2Tka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:40:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29590 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751419AbWI2Tk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:40:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: Arrr! Linux 2.6.18
Date: Fri, 29 Sep 2006 21:42:35 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org> <20060929014433.bc01e83c.akpm@osdl.org> <451D5D66.8030501@rtr.ca>
In-Reply-To: <451D5D66.8030501@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292142.36333.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 September 2006 19:52, Mark Lord wrote:
> Andrew Morton wrote:
> > On Fri, 29 Sep 2006 04:40:03 -0400
> > Mark Lord <lkml@rtr.ca> wrote:
> > 
> >> Linus Torvalds wrote:
> >>> ..
> >>> Cap'n Andrew Morton:
> >>>       Blimey! hvc_console suspend fix
> >> Mmm.. I wonder if this could be what killed resume-from-RAM
> >> on my notebook, between -rc6 and -final ?
> >>
> >> Andrew, can you send me just that one patch, and I'll try reverting it.
> ..
> > --- a/drivers/char/hvc_console.c~hvc_console-suspend-fix
> > +++ a/drivers/char/hvc_console.c
> 
> ARrrgyeeematey.. the Adm'rl was right about this,
> my kernel doesn't even use that source file.
> 
> I'll look through all of the post-rc6 changes and see if anything
> else might be a candidate.

Or could your .config change between -rc6 and -final?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
