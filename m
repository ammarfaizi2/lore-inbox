Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFLT3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFLT3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVFLT2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:28:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:23264 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261589AbVFLScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 14:32:11 -0400
Date: Sun, 12 Jun 2005 20:32:05 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Greg K-H <greg@kroah.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
In-Reply-To: <200506121136.35511.tomlins@cam.org>
Message-ID: <Pine.LNX.4.61.0506122026400.20430@phoenix.one.melware.de>
References: <11184761113499@kroah.com> <200506120929.03212.tomlins@cam.org>
 <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
 <200506121136.35511.tomlins@cam.org>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Ed Tomlinson wrote:
> On Sunday 12 June 2005 09:51, Armin Schindler wrote:
> > On Sun, 12 Jun 2005, Ed Tomlinson wrote:
> > > On Sunday 12 June 2005 04:44, Armin Schindler wrote:
> > > > It didn't follow the development, is devfs now obsolete in kernel?
> > > > If not, these funktions still makes sense.
> > > > 
> > > Armin,
> > > 
> > > From Documentation/feature-removal-schedule.txt
> > > 
> > > What:   devfs
> > > When:   July 2005
> > > Files:  fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
> > >         function calls throughout the kernel tree
> > > Why:    It has been unmaintained for a number of years, has unfixable
> > >         races, contains a naming policy within the kernel that is
> > >         against the LSB, and can be replaced by using udev.
> > > Who:    Greg Kroah-Hartman <greg@kroah.com>
> > > 
> > > This should not a surprise to anyone...
> > 
> > I know the status of devfs, but I never thought the removal will be
> > done in the middle of a stable line...
> 
> Armin,
> 
> Its all the same in 2.6 - the 2.odd.x development, 2.even.x stable model is no longer
> being used.  The current Linus kernel is 2.6.11.12, where the last .12 is the latest 
> 2.6.11 kernel with VIF (very important fixes) applied.

Yes, I know and I like this new model. But I didn't get the idea of changing 
'major' things from e.g. 2.6.11 to 2.6.12.

Thanks for the explanation.

Armin
