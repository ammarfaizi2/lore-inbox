Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUGJGPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUGJGPC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUGJGPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:15:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:15265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266158AbUGJGPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:15:00 -0400
Date: Fri, 9 Jul 2004 23:13:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-Id: <20040709231351.1b78b359.akpm@osdl.org>
In-Reply-To: <20040710061133.GB20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
	<20040708212923.406135f0.akpm@osdl.org>
	<20040709044205.GF20947@dualathlon.random>
	<20040708215645.16d0f227.akpm@osdl.org>
	<20040710001600.GT20947@dualathlon.random>
	<20040710010738.GX20947@dualathlon.random>
	<20040710045920.GY20947@dualathlon.random>
	<20040709225634.2eb0b8b0.akpm@osdl.org>
	<20040710061133.GB20947@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  the only real fixes are the other two ones, the page_is_mapped move is
>  just because I agree with Chris it's more correct to do the same thing
>  as block_write_full_page to get the very same behaviour from both.

OK, cool.  I was just making sure I wasn't missing something ;)
