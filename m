Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUF3OiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUF3OiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUF3OiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:38:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:30957 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S266682AbUF3OiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:38:17 -0400
Date: Wed, 30 Jun 2004 23:33:50 +0900 (JST)
Message-Id: <20040630.233350.74723167.taka@valinux.co.jp>
To: arjanv@redhat.com
Cc: iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [Lhms-devel] Re: new memory hotremoval patch
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1088595151.2706.12.camel@laptop.fenrus.com>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
	<1088595151.2706.12.camel@laptop.fenrus.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Page "remapping" is a mechanism to free a specified page by copying the
> > page content to a newly allocated replacement page and redirecting
> > references to the original page to the new page.
> > This was designed to reliably free specified pages, unlike the swapout
> > code.
> 
> are you 100% sure the locking is correct wrt O_DIRECT, AIO or futexes ??

Sure, it can handle that!
And it can handle pages on RAMDISK and sysfs and so on.


Thank you,
Hirokazu Takahashi.



