Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbWG1N5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWG1N5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWG1N5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:57:25 -0400
Received: from [212.76.86.78] ([212.76.86.78]:4621 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161155AbWG1N5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:57:24 -0400
From: Al Boldi <a1426z@gawab.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: patch for Documentation/initrd.txt?
Date: Fri, 28 Jul 2006 16:58:40 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607272026.57695.a1426z@gawab.com> <200607272335.36819.a1426z@gawab.com> <44C9244B.1020708@zytor.com>
In-Reply-To: <44C9244B.1020708@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281658.40771.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Al Boldi wrote:
> > H. Peter Anvin wrote:
> >> Al Boldi wrote:
> >>> Thanks for your very useful docPatch!
> >>>
> >>> OT, but your docPatch made me think of another way to init the kernel;
> >>> via tmpfs, i.e. initTmpFS.
> >>>
> >>> Can anybody see how that could be useful?
> >>
> >> Useful, yes, but this has turned out to be fairly complex.
> >
> > Sounds like somebody tried this before?
>
> Several people, yes.

This http://marc.theaimsgroup.com/?l=linux-kernel&m=107013630212011&w=4 looks 
rather trivial.

What am I missing here?

> >> tmpfs needs
> >> a *LOT* more of the system to be fully operational than ramfs, and the
> >> rootfs is initialized very early on, since one of its purposes is to
> >> eliminate special cases.
> >
> > So would it be possible to remap rootfs from ramfs to tmpfs, once tmpfs
> > is initialized, without actually doing another cpio?
>
> That sounds nasty.

I would call it an obvious hack, if it is necessary at all.  Plus it's only 
to kickstart things.

BTW, your pxebooter is great!

Thanks!

--
Al

