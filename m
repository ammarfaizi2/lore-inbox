Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVFBMPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVFBMPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFBMPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:15:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261387AbVFBMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:15:13 -0400
Date: Thu, 2 Jun 2005 14:15:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.12-rc5-mm2: "bic unavailable using TCP reno" messages
Message-ID: <20050602121511.GE4992@stusta.de>
References: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:28:24AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc5-mm1:
>...
> +tcp-tcp_infra.patch
>...
>  Steve Hemminger's TCP enhancements.
>...

I said "no" to CONFIG_TCP_CONG_BIC, and now my syslog is full of messages
   kernel: bic unavailable using TCP reno

I have no problem with such a message being shown once - but once should 
be enough.  

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

