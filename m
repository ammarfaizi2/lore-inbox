Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVCEFmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVCEFmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCEFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 00:36:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:5255 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263232AbVCEF3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 00:29:17 -0500
Date: Fri, 4 Mar 2005 21:28:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       chrisw@osdl.org
Subject: Re: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to
 security
Message-Id: <20050304212839.1d5aca4c.akpm@osdl.org>
In-Reply-To: <20050304195204.GA19711@locomotive.unixthugs.org>
References: <20050304195204.GA19711@locomotive.unixthugs.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Mahoney <jeffm@suse.com> wrote:
>
>  This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
>  filesystem-internal. As such, it should be excepted from the security
>  infrastructure to allow the filesystem to perform its own access control.

OK, thanks.  I'll assume that the other three patches are unchanged.

I don't think we've heard from the SELinux team regarding these patches?

(See http://www.zip.com.au/~akpm/linux/patches/stuff/selinux-reiserfs/)
