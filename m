Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUIJDIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUIJDIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUIJDIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:08:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:51353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267598AbUIJDIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:08:52 -0400
Date: Thu, 9 Sep 2004 20:06:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc1-bk14 Oops] In groups_search()
Message-Id: <20040909200650.787001fc.akpm@osdl.org>
In-Reply-To: <4141092B.2090608@bigpond.net.au>
References: <413FA9AE.90304@bigpond.net.au>
	<20040909010610.28ca50e1.akpm@osdl.org>
	<4140EE3E.5040602@bigpond.net.au>
	<20040909171450.6546ee7a.akpm@osdl.org>
	<4141092B.2090608@bigpond.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
>  Andrew Morton wrote:
>  > Peter Williams <pwil3058@bigpond.net.au> wrote:
>  > 
>  >>>Please try earlier snapshots, see if you can ascertain which one introduced
>  >>>the bug.
> 
>  bk10 is where the problem was introduced.

OK, thanks for hanging in there.

I've placed four backout patches at
http://www.zip.com.au/~akpm/linux/patches/stuff/pid-revert/.  Could you
please try them, see which one fixes it up?  

Grab the latest Linus snapshot and apply them in this order:

1-1911-3-2.patch
1-1901-1-17.patch
1-1860-1-29.patch
1-1860-1-28.patch

Thanks.
