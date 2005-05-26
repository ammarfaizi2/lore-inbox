Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVEZHxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVEZHxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEZHxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:53:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:52658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261254AbVEZHxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:53:07 -0400
Date: Thu, 26 May 2005 00:52:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
Message-Id: <20050526005212.1304e3c8.akpm@osdl.org>
In-Reply-To: <1117093494l.17165l.1l@werewolf.able.es>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<1117093494l.17165l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
>  I collected this from lkml:
> 
>  --- linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c.old	2005-05-17 00:05:28.000000000 +0200
>  +++ linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-05-17 00:05:49.000000000 +0200
>  @@ -118,7 +118,7 @@
>   };
>   
>   #define MAX_CACHE_LEAVES		4
>  -static unsigned short __devinitdata	num_cache_leaves;
>  +static unsigned short			num_cache_leaves;

Got it, thanks.
