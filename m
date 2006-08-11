Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWHKIch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWHKIch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHKIch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:32:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:12502 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750807AbWHKIcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:32:35 -0400
Subject: Re: [PATCH] make leds.h include relevant headers
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <44DC36CA.4010908@sipsolutions.net>
References: <44DC36CA.4010908@sipsolutions.net>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:32:14 +0100
Message-Id: <1155285134.6354.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 09:50 +0200, Johannes Berg wrote:
> This patch makes it possible to include linux/leds.h without first
> including list.h and spinlock.h.
> 
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

> --- wireless-dev.orig/include/linux/leds.h	2006-08-10 19:59:13.419652863 +0200
> +++ wireless-dev/include/linux/leds.h	2006-08-10 20:02:14.979652863 +0200
> @@ -12,6 +12,9 @@
>  #ifndef __LINUX_LEDS_H_INCLUDED
>  #define __LINUX_LEDS_H_INCLUDED
>  
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +
>  struct device;
>  struct class_device;
>  /*
> 
> 

