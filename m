Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUIMJWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUIMJWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUIMJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:22:43 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:57748 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266427AbUIMJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:22:41 -0400
Message-ID: <414566DC.8000008@yahoo.com.au>
Date: Mon, 13 Sep 2004 19:22:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
References: <20040913015003.5406abae.akpm@osdl.org>
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
> 
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/

> +sched-trivial-sched-changes.patch
> +sched-add-cpu_down_prepare-notifier.patch
> +sched-integrate-cpu-hotplug-and-sched-domains.patch
> +sched-arch_destroy_sched_domains-warning-fix.patch
> +sched-sched-add-load-balance-flag.patch
> +sched-remove-disjoint-numa-domains-setup.patch
> +sched-make-domain-setup-overridable.patch
> +sched-make-domain-setup-overridable-rename.patch
> +sched-ia64-add-disjoint-numa-domain-support.patch
> +sched-fix-domain-debug-for-isolcpus.patch
> +sched-enable-sd_load_balance.patch
> +sched-hotplug-add-a-cpu_down_failed-notifier.patch
> +sched-use-cpu_down_failed-notifier.patch
> +sched-fixes-for-ia64-domain-setup.patch
> 
>  CPU scheduler work.
> 

In particular, anyone who was having trouble with sched-domains and/or CPU
hotplug please test this.

It is supposed to fix all known issues, but some patches are fairly involved,
and not having been tested on problem hardware, there could be still some bugs.
Please let me know if anything goes bug.

Also, ia64 sched-domains setup is possibly still broken. If anyone boots this
on an Altix, please send over the full dmesg! Thanks.
