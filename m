Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268312AbUIJGVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268312AbUIJGVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIJGVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:21:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:12215 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268312AbUIJGUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:20:53 -0400
Date: Thu, 9 Sep 2004 23:18:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040909231858.770ab381.akpm@osdl.org>
In-Reply-To: <41413F64.40504@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
	<20040909171450.6546ee7a.akpm@osdl.org>
	<4141092B.2090608@bigpond.net.au>
	<20040909200650.787001fc.akpm@osdl.org>
	<41413F64.40504@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> > Grab the latest Linus snapshot and apply them in this order:
> > 
> > 1-1911-3-2.patch
> 
> Still there with this one PLUS I now get a whole bunch of "scheduling 
> while atomic" errors when I do "make install" which fails due to a 
> segmentation fault while doing the mkinitrd bit.

Yup, one or two of these patches are "fix up the previous patch" things.

> > 1-1901-1-17.patch
> > 1-1860-1-29.patch
> > 1-1860-1-28.patch

Please keep going ;)
