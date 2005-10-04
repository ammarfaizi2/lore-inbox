Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVJDUJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVJDUJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbVJDUJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:09:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48589 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964953AbVJDUJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:09:47 -0400
Date: Wed, 5 Oct 2005 06:09:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc3-git-current xfs compilation warnings
Message-ID: <20051005060946.A5455290@wobbly.melbourne.sgi.com>
References: <6bffcb0e0510040903i406e6870n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6bffcb0e0510040903i406e6870n@mail.gmail.com>; from michal.k.k.piotrowski@gmail.com on Tue, Oct 04, 2005 at 04:03:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 04:03:32PM +0000, Michal Piotrowski wrote:
> Hi,
> I have noticed this warnings while compiling xfs as module.
> 
>   CC [M]  fs/xfs/xfs_acl.o
> fs/xfs/xfs_acl.c: In function 'xfs_acl_access':
> fs/xfs/xfs_acl.c:445: warning: 'matched.ae_perm' may be used
> uninitialized in this function

These gcc v4 warnings are fixed in the current XFS devlopment
tree on oss.sgi.com - these will get merged at an appropriate
time.

> michal@debian:/usr/src/linux-git$ gcc --version
> gcc (GCC) 4.0.2 (Debian 4.0.2-2)

cheers.

-- 
Nathan
