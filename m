Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbUKKKYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbUKKKYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKKKXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:23:42 -0500
Received: from [213.80.72.10] ([213.80.72.10]:9739 "EHLO kubrik.opensource.se")
	by vger.kernel.org with ESMTP id S262181AbUKKKW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:22:26 -0500
Subject: Re: 2.6.10-rc1-mm5
From: Magnus Damm <damm@opensource.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041111021103.1573601f.akpm@osdl.org>
References: <20041111012333.1b529478.akpm@osdl.org>
	 <1100167792.8525.8.camel@localhost> <20041111021103.1573601f.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1100168666.8522.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 11 Nov 2004 11:24:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 11:11, Andrew Morton wrote:
> Magnus Damm <damm@opensource.se> wrote:
> >
> > It looks like the file "usr/initramfs_list" gets removed when applying
> >  the broken out patches (by "linux.patch") but the file is not removed
> >  when the combined patch is applied...
> 
> Can't do anything about that.  The file exists in -rc1, is removed by
> linus.patch and is created at build time when you build the post-rc1
> kernel.
> 
> In other words: you have to remove that file prior to unpatching.

I was comparing two source trees; one source tree with the combined
patch and one source tree with the series. But if everyone is aware that
they differ a wee bit and that is ok then I am happy.

> The problem will go away once -rc2-mm1 comes out.

Yes. Thank you.

/ magnus

