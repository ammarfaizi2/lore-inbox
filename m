Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUGAHVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUGAHVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUGAHVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:21:21 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:6547 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S264258AbUGAHVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:21:19 -0400
Date: Thu, 01 Jul 2004 16:16:47 +0900 (JST)
Message-Id: <20040701.161647.119874601.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org
Cc: iwamoto@valinux.co.jp
Subject: [patch] new memory hotremoval patch for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
References: <20040630111719.EBACF70A92@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> this is an updated version of my memory hotremoval patch.
> I'll only include the main patch which contains page remapping code.
> The other two files, which haven't changed much from April, can be
> found at http://people.valinux.co.jp/~iwamoto/mh.html .
	(snip)
> My patch supports remapping of normal pages, Takahashi's hugepage
> remapping patch will be posted in a few days.

I also post new hugepage remapping patches which is against linux-2.6.7.
I have change it to use objrmap so that the code become clean.

The patches can be downloaded from 
   http://people.valinux.co.jp/~taka/hpageremap.html .

There may remain some bugs. if you find them, would you let me know.

> I will be working on the following items.
> 
>   1.  Prototype implementation of memsection support.
>       It seems some people wants to hotremove small regions of memory
>       rather than zones or nodes.  A prototype implementation will
>       show how Takahashi's hugetlb page code can be used for such a
>       purpose.

This is my interst and I'll work on it.

>   2.  Handling of pages with dirty buffers without writing them back.
>       This is file system specific.  I plan to do against ext2 and
>       ext3.

Thank you,
Hirokazu Takahashi.




