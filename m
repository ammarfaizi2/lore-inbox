Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTKTCEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTKTCEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:04:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:21995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264261AbTKTCEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:04:09 -0500
Date: Wed, 19 Nov 2003 18:09:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: pinotj@club-internet.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-Id: <20031119180943.5d4f7774.akpm@osdl.org>
In-Reply-To: <mnet1.1069293035.2246.pinotj@club-internet.fr>
References: <mnet1.1069293035.2246.pinotj@club-internet.fr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pinotj@club-internet.fr wrote:
>
> kernel BUG at mm/slab.c:1957!
>  ---
> 
>  >Don't know, sorry.
> 
>  Is there any thing I can do to help figure out where does the problem comes from ? 

Well it's interesting that it is repeatable.

First thing to do is to eliminate hardware failures:

1: Is the oops always the same, or does the machine crash in other ways,
   with different backtraces?

2: Try running memtest86 on that machine for 12 hours or more.

3: Can the problem be reproduced on other machines?

4: try a different compiler version.

Thanks.
