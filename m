Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWGGU5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGGU5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGGU5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:57:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWGGU5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:57:52 -0400
Date: Fri, 7 Jul 2006 13:58:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC: 2.6 patch] remove kernel/kthread.c:kthread_stop_sem()
Message-Id: <20060707135816.6f1c02bd.akpm@osdl.org>
In-Reply-To: <20060707204541.GD26941@stusta.de>
References: <20060707204541.GD26941@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch moves the otherwise unused kthread_stop_sem() into 
> kthread_stop().
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 29 Jun 2006
> 
>  include/linux/kthread.h |   12 ------------
>  kernel/kthread.c        |   14 ++------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 

Hum, OK.  That's basically a `patch -R' of Alan's
"[patch] Add kthread_stop_sem()".

Alan, are you OK with reverting that?

