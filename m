Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRLQLKK>; Mon, 17 Dec 2001 06:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRLQLKB>; Mon, 17 Dec 2001 06:10:01 -0500
Received: from [62.98.191.18] ([62.98.191.18]:5380 "EHLO
	gandalf.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S276424AbRLQLJo>; Mon, 17 Dec 2001 06:09:44 -0500
Date: Mon, 17 Dec 2001 12:05:57 +0100 (CET)
From: Cristiano Paris <c.paris@libero.it>
To: Cristiano Paris <c.paris@libero.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 815EP Linux problem with 2.4.17-rc1 (fwd)
In-Reply-To: <Pine.LNX.4.33.0112162238460.21090-100000@gandalf.rhpk.springfield.inwind.it>
Message-ID: <Pine.LNX.4.33.0112171203150.427-100000@gandalf.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've recently bought a Asus Notebook, model L8490K which sports a 815EP
> chipset.
>
> I've installed the Slackware 8.0 distribution and soon recompiled the
> 2.4.17-rc1 kernel.
>
> After some time of using it I've experienced some kernel oops due to
> unhandled NULL pointer. I've just installed ksymoops so I'll try to debug
> the error myself but I would like to know which is the support status for
> this chipset. Have any problem been reported so far ?

The problem seems to occur only in kernel 2.4.x (I've tried both
2.4.17-rc1 and 2.4.13-ac5) but not in kernel 2.2.19.

Under Windows 2000 I haven't noticed anythoing strange.

The latest kernel oops I saw is :

Unable to handle kernel paging request at virtual address ....

while the call trace is :

EIP : __mark_inode_dirty()
try_to_free_buffers()
block_sync_page()
kernel_thread()

Thanks

Cristiano

