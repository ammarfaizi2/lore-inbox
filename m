Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSJII2J>; Wed, 9 Oct 2002 04:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJII2J>; Wed, 9 Oct 2002 04:28:09 -0400
Received: from denise.shiny.it ([194.20.232.1]:64968 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261281AbSJII2I>;
	Wed, 9 Oct 2002 04:28:08 -0400
Message-ID: <XFMail.20021009103325.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1034104637.29468.1483.camel@phantasy>
Date: Wed, 09 Oct 2002 10:33:25 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: riel@conectiva.com.br, akpm@digeo.com, linux-kernel@vger.kernel.org,
       Chris Wedgwood <cw@f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The point of O_STREAMING is one change: drop pages in the pagecache
> behind our current position, that are free-able, because we know we will
> never want them.

Does it drop pages unconditionally ?  What happens if I do a
streaming_cat largedatabase > /dev/null while other processes
are working on it ?  It's not a good thing to remove the whole
cached data other apps are working on.


Bye.

