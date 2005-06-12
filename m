Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVFLNyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVFLNyv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVFLNyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:54:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:40179 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262613AbVFLNvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:51:32 -0400
Date: Sun, 12 Jun 2005 15:51:19 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Greg K-H <greg@kroah.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove devfs_mk_cdev() function from the kernel tree
In-Reply-To: <200506120929.03212.tomlins@cam.org>
Message-ID: <Pine.LNX.4.61.0506121543200.15593@phoenix.one.melware.de>
References: <11184761113499@kroah.com> <Pine.LNX.4.61.0506121042420.30907@phoenix.one.melware.de>
 <200506120929.03212.tomlins@cam.org>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Ed Tomlinson wrote:
> On Sunday 12 June 2005 04:44, Armin Schindler wrote:
> > It didn't follow the development, is devfs now obsolete in kernel?
> > If not, these funktions still makes sense.
> > 
> Armin,
> 
> From Documentation/feature-removal-schedule.txt
> 
> What:   devfs
> When:   July 2005
> Files:  fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
>         function calls throughout the kernel tree
> Why:    It has been unmaintained for a number of years, has unfixable
>         races, contains a naming policy within the kernel that is
>         against the LSB, and can be replaced by using udev.
> Who:    Greg Kroah-Hartman <greg@kroah.com>
> 
> This should not a surprise to anyone...

I know the status of devfs, but I never thought the removal will be
done in the middle of a stable line...

Armin
