Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWEYQUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWEYQUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWEYQUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:20:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751032AbWEYQUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:20:19 -0400
Date: Thu, 25 May 2006 09:19:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 03/33] radixtree: hole scanning functions
Message-Id: <20060525091946.2b57840f.akpm@osdl.org>
In-Reply-To: <348469537.15678@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469537.15678@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Introduce a pair of functions to scan radix tree for hole/empty item.
>

There's a userspace radix-tree test harness at
http://www.zip.com.au/~akpm/linux/patches/stuff/rtth.tar.gz.

If/when these new features are merged up, it would be good to have new
testcases added to that suite, please.

In the meanwhile you may care to develop those tests anwyway, see if you
can trip up the new features.

