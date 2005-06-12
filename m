Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVFLPfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVFLPfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFLPfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:35:55 -0400
Received: from ppp-6-84.mtl.aei.ca ([206.123.6.84]:1230 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262625AbVFLPfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:35:46 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Armin Schindler <armin@melware.de>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
Date: Sun, 12 Jun 2005 11:36:34 -0400
User-Agent: KMail/1.7.2
Cc: Greg K-H <greg@kroah.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <11184761113499@kroah.com> <200506120929.03212.tomlins@cam.org> <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
In-Reply-To: <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506121136.35511.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 09:51, Armin Schindler wrote:
> On Sun, 12 Jun 2005, Ed Tomlinson wrote:
> > On Sunday 12 June 2005 04:44, Armin Schindler wrote:
> > > It didn't follow the development, is devfs now obsolete in kernel?
> > > If not, these funktions still makes sense.
> > > 
> > Armin,
> > 
> > From Documentation/feature-removal-schedule.txt
> > 
> > What:   devfs
> > When:   July 2005
> > Files:  fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
> >         function calls throughout the kernel tree
> > Why:    It has been unmaintained for a number of years, has unfixable
> >         races, contains a naming policy within the kernel that is
> >         against the LSB, and can be replaced by using udev.
> > Who:    Greg Kroah-Hartman <greg@kroah.com>
> > 
> > This should not a surprise to anyone...
> 
> I know the status of devfs, but I never thought the removal will be
> done in the middle of a stable line...

Armin,

Its all the same in 2.6 - the 2.odd.x development, 2.even.x stable model is no longer
being used.  The current Linus kernel is 2.6.11.12, where the last .12 is the latest 
2.6.11 kernel with VIF (very important fixes) applied.

Ed Tomlinson
