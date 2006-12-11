Return-Path: <linux-kernel-owner+w=401wt.eu-S936301AbWLKO5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936301AbWLKO5R (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936340AbWLKO5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:57:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3129 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S936335AbWLKO5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:57:14 -0500
Date: Mon, 11 Dec 2006 15:57:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, stephane eranian <eranain@hpl.hp.com>,
       Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: 2.6.19-mm1: i386: unused idle notifiers added
Message-ID: <20061211145722.GM10351@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
> +x86_64-mm-i386-add-idle-notifier.patch
> 
>  x86 tree update
>...

This patch adds code and EXPORT_SYMBOL's that bloat the kernel for 
everyone but are currently completely unused in the kernel with the sole 
justification
  "We use the idle notifier in the context of perfmon."

The people who whine loudly when I'm sending patches to remove code that 
is unused within the kernel should consider that they could save some 
tears when NAK'ing such patches until an actual user gets included in 
the kernel...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

