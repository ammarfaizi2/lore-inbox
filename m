Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWG0Ufp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWG0Ufp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWG0Ufp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:35:45 -0400
Received: from [212.33.163.93] ([212.33.163.93]:62475 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750736AbWG0Ufo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:35:44 -0400
From: Al Boldi <a1426z@gawab.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: patch for Documentation/initrd.txt?
Date: Thu, 27 Jul 2006 23:35:36 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607272026.57695.a1426z@gawab.com> <44C90B6F.5070000@zytor.com>
In-Reply-To: <44C90B6F.5070000@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607272335.36819.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Al Boldi wrote:
> > Thanks for your very useful docPatch!
> >
> > OT, but your docPatch made me think of another way to init the kernel;
> > via tmpfs, i.e. initTmpFS.
> >
> > Can anybody see how that could be useful?
>
> Useful, yes, but this has turned out to be fairly complex.

Sounds like somebody tried this before?

> tmpfs needs
> a *LOT* more of the system to be fully operational than ramfs, and the
> rootfs is initialized very early on, since one of its purposes is to
> eliminate special cases.

So would it be possible to remap rootfs from ramfs to tmpfs, once tmpfs is 
initialized, without actually doing another cpio?

Thanks!

--
Al

