Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVKWAvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVKWAvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVKWAvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:51:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030285AbVKWAvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:51:08 -0500
Date: Tue, 22 Nov 2005 16:50:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <20051122150002.26adf913.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu>
 <20051122150002.26adf913.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Andrew Morton wrote:

> Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
> >
> >                 from fs/compat_ioctl.c:52,
> >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
> > include/linux/ext3_fs.h: In function 'ext3_raw_inode':
> > include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type
> 
> This might help?

Why does it happen at all, though? And why aren't more people reporting 
this? Something strange going on.

		Linus
