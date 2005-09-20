Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVITXGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVITXGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVITXGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:06:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750708AbVITXGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:06:04 -0400
Date: Tue, 20 Sep 2005 16:06:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] intel_cacheinfo: remove MAX_CACHE_LEAVES limit
Message-Id: <20050920160604.5e022fa8.akpm@osdl.org>
In-Reply-To: <20050919121435.A10231@unix-os.sc.intel.com>
References: <20050919121435.A10231@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>
> Remove the MAX_CACHE_LEAVES limit from the routine which calculates the
> number of cache levels using cpuid(4)

Why?  Why was the code there originally, and why is it required that it be
removed, and why is it safe to remove it?

(IOW: your description of this patch is inadequate: it describes what was
done, but not why it was done).

Thanks.
