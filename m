Return-Path: <linux-kernel-owner+w=401wt.eu-S1753932AbWL2Agk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbWL2Agk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 19:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbWL2Agk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 19:36:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1699 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753932AbWL2Agk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 19:36:40 -0500
Date: Fri, 29 Dec 2006 01:36:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@hpl.hp.com>
Subject: 2.6.20-rc2-mm1: i386-idle-notifier again
Message-ID: <20061229003642.GM20714@stusta.de>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc1-mm1:
>...
> +add-i386-idle-notifier-take-3.patch
>...
>  x86/x86_64 updates
>...

As already said:
- merges infrastructure without any users (the corresponding x86_64 code
  is now merged and bloating the kernel unused for nearly one year)
- the planned user (perfmon) doesn't use the EXPORT_SYMBOL's that will
  bloat the kernel even if the code using this infrastructure will ever
  be merged

Let's either get the user into -mm, too, or drop the
infrastructure on all architectures until it's actually used.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

