Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUH2W7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUH2W7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUH2W73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:59:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:21436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268353AbUH2W73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:59:29 -0400
Date: Sun, 29 Aug 2004 15:57:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 kernel BUG at fs/jbd/checkpoint.c:646!
Message-Id: <20040829155734.0e47e6e0.akpm@osdl.org>
In-Reply-To: <1093732735.1866.2.camel@rakieeta>
References: <1093732735.1866.2.camel@rakieeta>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
>
> this keeps happening on the SMP highmem box under heavy sync IO load.
> 
>  kernel BUG at fs/jbd/checkpoint.c:646!

Are you using the data=journal mount option?
