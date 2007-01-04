Return-Path: <linux-kernel-owner+w=401wt.eu-S1030196AbXADTc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbXADTc2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbXADTc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:32:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46614 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030196AbXADTc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:32:27 -0500
Date: Thu, 4 Jan 2007 11:32:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104192223.GX17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0701041130300.3661@woody.osdl.org>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
 <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
 <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
 <20070104192223.GX17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Al Viro wrote:
> 
> PS: what would be the sane strategy for timer series merge, BTW?

I think Andrew may care more. I just care about it happening after 2.6.20.

Whether we can do it really early after that, or whether we should do it 
as the last thing just before releasing -rc1 (to avoid having other people 
have to fix up conflicts during the merge window), who knows..

			Linus
