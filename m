Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWEKRrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWEKRrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWEKRrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:47:41 -0400
Received: from xenotime.net ([66.160.160.81]:37036 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030398AbWEKRrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:47:41 -0400
Date: Thu, 11 May 2006 10:50:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Suzuki <suzuki@in.ibm.com>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org, suparna@in.ibm.com,
       amitarora@in.ibm.com
Subject: Re: [BUG] Reiserfs: reiserfs_panic while running fs stress tests
Message-Id: <20060511105006.e4811957.rdunlap@xenotime.net>
In-Reply-To: <445ADA05.5000801@in.ibm.com>
References: <445ADA05.5000801@in.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 May 2006 10:22:21 +0530 Suzuki wrote:

> Hi,
> 
> 
> I was working on a reiserfs panic with 2.6.17-rc3, while running fs
> stress tests.

Hi,
What test(s) do you use?

> The panic message looked like :
> 
> " REISERFS: panic (device Null superblock): reiserfs[4248]: assertion
> !(truncate && (REISERFS_I(inode)->i_flags & i_link_saved_truncate_mask)
> ) failed at fs/reiserfs/super.c:328:add_save_link: saved link already re
> exists for truncated inode 13b5a "

Thanks,
---
~Randy
