Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUHaC5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUHaC5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 22:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUHaC5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 22:57:10 -0400
Received: from cathy.bmts.com ([216.183.128.202]:52370 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S266316AbUHaC5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 22:57:06 -0400
Date: Mon, 30 Aug 2004 22:56:38 -0400
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 can't compile a kernel
Message-Id: <20040830225638.02cd479c.mikeserv@bmts.com>
In-Reply-To: <20040829202106.181784a3.akpm@osdl.org>
References: <114120000.1093830897@[10.10.2.4]>
	<20040829202106.181784a3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, rc1-mm1 does everything right apart from reading data from
> files.
> 
> Reverting 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch
> 
> then
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch
> 
> will help.

Thanks, that solved a few strange problems for me as well. Little
things I couldn't quite put my finger on at first. Little things that
didn't happen if I booted other kernels. Things like Mozilla
browsers deleting their cache on startup (like it would if the browser
didn't exit properly on last run), problems with the back and forward
history in the browsers, tar truncating files and padding with zeros,
a music player crashing because it was unable to create its playlist
database and last but not least sure enough, I couldn't compile this
kernel (good thing I always keep a few previous kernels around :-)

Mike Houston

