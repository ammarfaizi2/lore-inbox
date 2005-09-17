Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVIQU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVIQU7z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVIQU7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 16:59:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751195AbVIQU7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 16:59:54 -0400
Date: Sat, 17 Sep 2005 13:58:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: lserinol@gmail.com
Cc: jlan@engr.sgi.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, guillaume.thouvenin@bull.net,
       kaigai@ak.jp.nec.com, elsa-devel@lists.sourceforge.net,
       erikj@subway.americas.sgi.com, jh@sgi.com
Subject: Re: [PATCH] per process I/O statistics for userspace
Message-Id: <20050917135832.501f2cfd.akpm@osdl.org>
In-Reply-To: <2c1942a705091710363f463b18@mail.gmail.com>
References: <2c1942a7050912052759c7f730@mail.gmail.com>
	<20050914092338.GA2260@elf.ucw.cz>
	<2c1942a705091413171e63bf55@mail.gmail.com>
	<20050914132437.7c32b739.akpm@osdl.org>
	<432890BA.5090907@engr.sgi.com>
	<2c1942a705091710363f463b18@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Levent Serinol <lserinol@gmail.com> wrote:
>
> Hi Andrew,
> 

You inspired me.  Please see
http://www.zip.com.au/~akpm/linux/patches/stuff/top-posting.txt

>  What's your last decision about the patch ?

To wait and see what the system accounting guys come up with.  If we export
this info in /proc then it'll need to remain exported for ever.  So if/when
the system accounting people export it by other means, the info will be
duplicated.

