Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTENI2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTENI23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:28:29 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:10768 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261312AbTENI2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:28:20 -0400
Date: Wed, 14 May 2003 09:41:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.69  eventpollfs configuration option
Message-ID: <20030514094102.B9474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christopher Hoover <ch@murgatroid.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030514012823.A4128@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030514012823.A4128@heavens.murgatroid.com>; from ch@murgatroid.com on Wed, May 14, 2003 at 01:28:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 01:28:23AM -0700, Christopher Hoover wrote:
> diff -X /home/ch/src/dontdiff.txt -Naurp linux-2.5.69.orig/fs/Kconfig linux-2.5.69/fs/Kconfig
> --- linux-2.5.69.orig/fs/Kconfig	2003-05-04 16:53:32.000000000 -0700
> +++ linux-2.5.69/fs/Kconfig	2003-05-14 01:14:26.000000000 -0700
> @@ -835,6 +835,13 @@ config RAMFS
>  	  say M here and read <file:Documentation/modules.txt>.  The module
>  	  will be called ramfs.
>  
> +config EVENTPOLLFS
> +       bool "Efficient event polling (epoll)"
> +       default y
> +       ---help---
> +       Say Y if you want epoll support which is an efficent event
> +       polling implementation.

I think CONFIG_EPOLL is a better name - the fileystem is an implementation detail.

Patch looks fine otherwise, thanks a lot for all this nice work!
