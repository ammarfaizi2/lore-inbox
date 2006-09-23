Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWIWIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWIWIuz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWIWIuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:50:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbWIWIuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:50:54 -0400
Date: Sat, 23 Sep 2006 01:50:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Restore the original TX FIFO overflow process.
Message-Id: <20060923015041.54e1aa51.akpm@osdl.org>
In-Reply-To: <1158953401.2630.0.camel@localhost.localdomain>
References: <1158953401.2630.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 15:30:01 -0400
Jesse Huang <jesse@icplus.com.tw> wrote:

> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change Logs:
>    - Restore the original TX FIFO overflow process.
> 
> Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
> 
> ...
>
> +						txthreshold = ioread16 (ioaddr + TxStartThresh);

Your patch ip100a-fix-tx-pause-bug-reset_tx-intr_handler.patch removed
TxStartThresh, so it won't compile.

I don't have a clue what's happening with this driver - I'll drop everything.

I suggest you send a complete new patch series against Jeff's latest tree. 
I'll send you a copy of that.


