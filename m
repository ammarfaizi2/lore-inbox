Return-Path: <linux-kernel-owner+w=401wt.eu-S932702AbXAJDZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbXAJDZE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbXAJDZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:25:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38235 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932702AbXAJDZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:25:03 -0500
Date: Tue, 9 Jan 2007 19:24:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: bad unlock balance detected! -- [<c017986d>]
 generic_sync_sb_inodes+0x26a/0x275
Message-Id: <20070109192459.1820814f.akpm@osdl.org>
In-Reply-To: <a44ae5cd0701091917o13fc3badud118364a5e8be9dd@mail.gmail.com>
References: <a44ae5cd0701091917o13fc3badud118364a5e8be9dd@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 21:17:30 -0600
"Miles Lane" <miles.lane@gmail.com> wrote:

> [ BUG: bad unlock balance detected! ]
> -------------------------------------
> swapper/0 is trying to release lock (inode_lock) at:
> [<c017986d>] generic_sync_sb_inodes+0x26a/0x275

If this is 2.6.20-rc3-mm1, please ensure that the fixes from
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/hot-fixes
are applied.
