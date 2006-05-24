Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWEXBDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWEXBDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWEXBDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:03:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbWEXBDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:03:15 -0400
Date: Tue, 23 May 2006 18:02:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/9] [I/OAT] Add a sysctl for tuning the I/OAT offloaded
 I/O threshold
Message-Id: <20060523180253.5d28649f.akpm@osdl.org>
In-Reply-To: <20060524002021.19403.15607.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
	<20060524002021.19403.15607.stgit@gitlost.site>
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
>  Signed-off-by: Chris Leech <christopher.leech@intel.com>
>  ---
> 
>   include/linux/sysctl.h     |    1 +
>   include/net/tcp.h          |    1 +
>   net/core/user_dma.c        |    4 ++++
>   net/ipv4/sysctl_net_ipv4.c |   10 ++++++++++
>   4 files changed, 16 insertions(+), 0 deletions(-)
> 

Documentation/networking/ip-sysctl.txt too, please.
