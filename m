Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUEYJGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUEYJGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUEYJGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:06:40 -0400
Received: from denise.shiny.it ([194.20.232.1]:26016 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S264820AbUEYJGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:06:39 -0400
Date: Tue, 25 May 2004 11:05:57 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
cc: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.6 IDE shutdown problems.
In-Reply-To: <20040524171656.GA19026@bounceswoosh.org>
Message-ID: <Pine.LNX.4.58.0405251101240.1197@denise.shiny.it>
References: <BAY18-F105X7rz6AvEm0002622f@hotmail.com>
 <200405151506.20765.bzolnier@elka.pw.edu.pl> <c8bdqv$lib$1@gatekeeper.tmr.com>
 <20040524024136.GB2502@zero> <20040524171656.GA19026@bounceswoosh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 May 2004, Eric D. Mudama wrote:

> Picture a nice fast drive doing 100 writes/second to the media... if
> you give it over 200 writes at a time, it'll occupy your 2 seconds.
> Newer drives with 8MB or larger buffers are certainly capable of
> caching a lot more than 200 writes...

Quite unlikely. Usually disks have a big cache but it can hold a very
limited number of blocks. 8MB of cache is probably divided in 8 blocks
of 1MB each.


--
Giuliano.
