Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCTXfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCTXfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVCTXfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:35:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:57046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261355AbVCTXfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:35:30 -0500
Date: Sun, 20 Mar 2005 15:34:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, christoph@graphe.net
Subject: Re: [patch] del_timer_sync scalability patch
Message-Id: <20050320153446.32a9215a.akpm@osdl.org>
In-Reply-To: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
References: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> We did exactly the same thing about 10 months back.  Nice to
> see that independent people came up with exactly the same
> solution that we proposed 10 months back.

Well the same question applies.  Christoph, which code is calling
del_timer_sync() so often that you noticed?

>  In fact, this patch
> is line-by-line identical to the one we post.

I assume that's not a coincidence.

> Hope Andrew is going to take the patch this time.

Hope Kenneth is going to test the alternate del_timer_sync patches in next
-mm ;)

