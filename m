Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUCEXEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUCEXEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:04:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:56016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbUCEXES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:04:18 -0500
Date: Fri, 5 Mar 2004 15:06:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/timer.c:370!
Message-Id: <20040305150615.0ae07114.akpm@osdl.org>
In-Reply-To: <20040305174049.GA1759@conectiva.com.br>
References: <20040305174049.GA1759@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Bruno Leitner <fbl@conectiva.com.br> wrote:
>
> My laptop is an Acer TravelMate 630 and somewhere between 2.6.2 and 2.6.3-rc2 
> begins returning an oops right after boot.
> 
> kernel BUG at kernel/timer.c:370!

Oh fantastic.  Something scrogged the timer lists.

I suggest you try stripping your kernel config down the the bare minimum
which is needed to boot, see if that fixes it and if so, start
reintroducing things until you've worked out which driver is causing the
problem.

