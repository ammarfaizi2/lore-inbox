Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVCHDr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVCHDr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVCHDrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 22:47:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:21471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261395AbVCHDoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 22:44:08 -0500
Date: Mon, 7 Mar 2005 19:43:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeffrey Mahoney <jeffm@suse.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, chrisw@osdl.org
Subject: Re: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to security
Message-ID: <20050308034355.GZ5389@shell0.pdx.osdl.net>
References: <20050304195204.GA19711@locomotive.unixthugs.org> <20050304212839.1d5aca4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304212839.1d5aca4c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Jeffrey Mahoney <jeffm@suse.com> wrote:
> >
> >  This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
> >  filesystem-internal. As such, it should be excepted from the security
> >  infrastructure to allow the filesystem to perform its own access control.
> 
> OK, thanks.  I'll assume that the other three patches are unchanged.
> 
> I don't think we've heard from the SELinux team regarding these patches?

I've no issue with these patches.

Acked-by: Chris Wright <chrisw@osdl.org>
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
