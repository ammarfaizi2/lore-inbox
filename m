Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUAPEeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 23:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUAPEeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 23:34:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:63138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263726AbUAPEeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 23:34:13 -0500
Date: Thu, 15 Jan 2004 20:34:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: marcel cotta <marcel@kriminell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
Message-Id: <20040115203419.76332f6a.akpm@osdl.org>
In-Reply-To: <400751B1.40608@kriminell.com>
References: <400751B1.40608@kriminell.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marcel cotta <marcel@kriminell.com> wrote:
>
> i got this oops after the box swapped like crazy under X for about 5 
>  minutes
>  while swapping it was nearly unusable (jerky mouse, console switching 
>  took 10 seconds)
>  the extreme performance drop is always reproducible when swapping starts
> 
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/swapfile.c:806!

Amazing.  Are you using a swapfile, or are you swapping to a block device?


