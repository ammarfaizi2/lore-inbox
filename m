Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVCGPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVCGPAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 10:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCGPAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 10:00:52 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:36762 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261525AbVCGPAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 10:00:48 -0500
Subject: Re: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to
	security
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeffrey Mahoney <jeffm@suse.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20050304212839.1d5aca4c.akpm@osdl.org>
References: <20050304195204.GA19711@locomotive.unixthugs.org>
	 <20050304212839.1d5aca4c.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 07 Mar 2005 09:53:01 -0500
Message-Id: <1110207181.29984.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 21:28 -0800, Andrew Morton wrote:
> Jeffrey Mahoney <jeffm@suse.com> wrote:
> >
> >  This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
> >  filesystem-internal. As such, it should be excepted from the security
> >  infrastructure to allow the filesystem to perform its own access control.
> 
> OK, thanks.  I'll assume that the other three patches are unchanged.
> 
> I don't think we've heard from the SELinux team regarding these patches?
> 
> (See http://www.zip.com.au/~akpm/linux/patches/stuff/selinux-reiserfs/)

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

