Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVELPQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVELPQE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVELPQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:16:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:48620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262010AbVELPPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:15:48 -0400
Date: Thu, 12 May 2005 08:09:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Vladimir Saveliev <vs@namesys.com>
Subject: Re: 2.6.12-rc4-mm1
Message-Id: <20050512080951.3e41f115.akpm@osdl.org>
In-Reply-To: <42834E6D.8060408@reub.net>
References: <20050512033100.017958f6.akpm@osdl.org>
	<42834E6D.8060408@reub.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi,
> 
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/
> > 
> > - Added Herbert Xu's ipsec tree to the -mm lineup, as git-ipsec.patch
> > 
> > - Lots of updates all over the place
> > 
> > 
> > Changes since 2.6.12-rc3-mm3:
> 
> Just compiled this one up and this appeared in the log:
> 
> eth0: no IPv6 routers present
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> ------------[ cut here ]------------
> kernel BUG at include/asm/spinlock.h:99!

err, yes.

> Is the patch "reiser4-sb_sync_inodes-cleanup.patch" likely to be the culprit?

It is.  Seems I only got sent half a patch?
