Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUARO1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 09:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUARO1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 09:27:14 -0500
Received: from dp.samba.org ([66.70.73.150]:2718 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261731AbUARO1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 09:27:10 -0500
Date: Mon, 19 Jan 2004 01:25:14 +1100
From: Anton Blanchard <anton@samba.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Limit hash table size
Message-ID: <20040118142514.GG6293@krispykreme>
References: <B05667366EE6204181EABE9C1B1C0EB580245C@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB580245C@scsmsx401.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> To address Anton's concerns on PPC64, we have revised the patch to
> enforce maximum size base on number of entry instead of page order.  So
> differences in page size/pointer size etc doesn't affect the final
> calculation.  The upper bound is capped at 2M.  All numbers on x86
> remain the same as we don't want to disturb already established and
> working number.  See patch at the end of the email.  It is diff'ed
> relative to 2.6.1-mm3 tree.

That sounds reasonable to me.

Anton
