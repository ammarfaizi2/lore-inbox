Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUIESnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUIESnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUIESnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:43:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:41884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266903AbUIESm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:42:58 -0400
Date: Sun, 5 Sep 2004 11:31:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: eric@cisu.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quick Syscall question
Message-Id: <20040905113114.313efdf2.rddunlap@osdl.org>
In-Reply-To: <200409051317.42691.eric@cisu.net>
References: <200409051317.42691.eric@cisu.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Sep 2004 13:17:42 -0500 Eric Bambach wrote:

| Hello,
| 
| 	This may seem like a silly question, however we were all beginning 
| programmers once ;)
| 
| 	I want to do some manipulating of network interfaces and routing and such. I 
| am reading through some of the linux net sources but am confused on what are 
| internal, kernel-only functions and what are externally visable syscalls. How 
| can I tell from the source what is user-space visable that I can hook into 
| and what is intternel stuff? Should I just be looking at headers or do I have 
| to delve into the .c sources? I can do either, I just need a pointer on where 
| to start and what I should be looking for.

Most syscalls are listed in include/linux/syscalls.h.
Also look in include/asm-*/unistd.h.
Also in entry.S in arch/*/ (various sub-directory levels).

--
~Randy
