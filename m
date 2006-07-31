Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWGaU5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWGaU5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWGaU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:57:38 -0400
Received: from [212.76.92.124] ([212.76.92.124]:16400 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932272AbWGaU5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:57:37 -0400
From: Al Boldi <a1426z@gawab.com>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead of ramfs
Date: Mon, 31 Jul 2006 23:58:41 +0300
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
References: <200607301808.14299.a1426z@gawab.com> <200607310003.56832.a1426z@gawab.com> <20060731193034.GU2654@sequoia.sous-sol.org>
In-Reply-To: <20060731193034.GU2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607312358.41199.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Al Boldi (a1426z@gawab.com) wrote:
> > Being semantically the same, while not exhibiting ramfs pitfalls, makes
> > it suitable to be pushed into the -stable tree, IMHO.
>
> You are failing to show how this is a critical type bugfix for -stable.
> We are picky about -stable additions because we don't want to undermine
> the value of the -stable tree.

If you mean critical as in "the kernel panics on boot without this patch", 
then yes, this patch is not critical.

But if you think it's important to allow -stable to make full use of rootfs, 
then this patch offers a much needed fix, by simply replugging existing 
code.

Again, it's your call.


Thanks!

--
Al

