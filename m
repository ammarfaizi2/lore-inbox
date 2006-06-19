Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWFSU7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWFSU7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWFSU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:59:05 -0400
Received: from www.osadl.org ([213.239.205.134]:50606 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964886AbWFSU7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:59:03 -0400
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, mingo@elte.hr
In-Reply-To: <20060619130948.6ea3998c.rdunlap@xenotime.net>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 23:00:22 +0200
Message-Id: <1150750822.29299.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

On Mon, 2006-06-19 at 13:09 -0700, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix kernel-doc formatting in ktime.h and hrtimer.[ch] files.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  include/linux/hrtimer.h |    3 ---
>  include/linux/ktime.h   |    8 --------
>  kernel/hrtimer.c        |   11 +----------
>  3 files changed, 1 insertion(+), 21 deletions(-)
> 
> --- linux-2617-pv.orig/include/linux/ktime.h
> +++ linux-2617-pv/include/linux/ktime.h
> @@ -66,7 +66,6 @@ typedef union {
>  
>  /**
>   * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
> - *
>   * @secs:	seconds to set
>   * @nsecs:	nanoseconds to set
>   *
<.....>

Is there any real reason for doing this, expect for removing the blank
comment lines ? 

My personal preference is to keep that line, as it makes it easier to
read. But as always: de gustibus non est disputandum :)

	tglx




