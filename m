Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWG3VD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWG3VD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 17:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWG3VD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 17:03:26 -0400
Received: from [212.33.163.22] ([212.33.163.22]:17167 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932322AbWG3VDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 17:03:24 -0400
From: Al Boldi <a1426z@gawab.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead of ramfs
Date: Mon, 31 Jul 2006 00:03:56 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
References: <200607301808.14299.a1426z@gawab.com> <20060730175109.GA20777@kroah.com>
In-Reply-To: <20060730175109.GA20777@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607310003.56832.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Jul 30, 2006 at 06:08:14PM +0300, Al Boldi wrote:
> > Replugs rootfs to use tmpfs instead of ramfs as a Kconfig option.
> >
> > This patch is based on John Zielinski's
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=107013630212011&w=4
> > patch.
> >
> > Modified for 2.6.17.
> >
> > RunTime tested on i386.
> >
> > This trivial patch should go into 2.6.18.
>
> This looks like a new feature.  What problem does it fix that would make
> it acceptable to add to the -stable tree?

Well, ramfs has some pitfalls, which doesn't make it suitable for a 
long-lived rootfs.  OTOH, tmpfs is much more mature, while semantically the 
same.

Being semantically the same, while not exhibiting ramfs pitfalls, makes it 
suitable to be pushed into the -stable tree, IMHO.

It's your call, but this patch should have been in 2.6 since day 1.

Thanks!

--
Al

