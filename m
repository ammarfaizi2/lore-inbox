Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268359AbUH2XFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268359AbUH2XFL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUH2XFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:05:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:34240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268359AbUH2XEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:04:49 -0400
Date: Sun, 29 Aug 2004 16:02:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 kjournald: page allocation failure. order:1,
 mode:0x20
Message-Id: <20040829160257.3b881fef.akpm@osdl.org>
In-Reply-To: <1093794970.1751.10.camel@rakieeta>
References: <1093794970.1751.10.camel@rakieeta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
>
> after creating several GB of data in small files on the SMP highmem box
>  the
> 
>  kjournald: page allocation failure. order:1, mode:0x20
> 
> 
>  start flooding the logs, load goes to sth around 1k, writing processes
>  get stuck in D state and the system needs hard reset.
> 
>  Anyone else is experiencing that kind of problems?
> 
>  Im running sw raid1 on that box, not preemtible kernel.

There should have been a stack trace as well.  Please send it.
