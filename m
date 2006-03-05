Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752154AbWCEHW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbWCEHW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEHW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:22:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752147AbWCEHW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:22:57 -0500
Date: Sat, 4 Mar 2006 23:21:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/8] [I/OAT] Add a sysctl for tuning the I/OAT offloaded
 I/O threshold
Message-Id: <20060304232124.621ba696.akpm@osdl.org>
In-Reply-To: <20060303214234.11908.99495.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214234.11908.99495.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> Any socket recv of less than this ammount will not be offloaded
> 
> ...
>
> +int sysctl_tcp_dma_copybreak = NET_DMA_DEFAULT_COPYBREAK;

Is it appropriate that this tunable be kernel-wide, rather than more
finely-grained?

