Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbTGHNv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbTGHNvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:51:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10893 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S267323AbTGHNvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:51:19 -0400
Date: Tue, 8 Jul 2003 15:05:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
Message-ID: <20030708140546.GA15612@mail.jlokier.co.uk>
References: <Pine.LNX.4.53.0307071655470.22074@chaos> <20030708003656.GC12127@mail.jlokier.co.uk> <Pine.LNX.4.53.0307080749160.24488@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307080749160.24488@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > The offset argument to mmap2 is divided by PAGE_SIZE.
> > That is the whole point of mmap2 :)
> 
> Okay. Do you know where that's documented? Nothing in linux/Documentation,
> and nothing in any headers. Do you have to read the code to find out?
> 
> So, the address is now the offset in PAGES, not bytes. Seems logical,
> but there is no clue in any documentation.

I found this great command which really helps.  Only 1337 kernel
gnurus know about it, now u can be 1 2 :)

$ man mmap2
[...]
       The  function mmap2 operates in exactly the same way as mmap(2), except
       that the final argument specifies the offset into the file in units  of
       the  system  page  size  (instead of bytes).

-- Jamie
