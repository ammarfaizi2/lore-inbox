Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTIGRgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTIGReV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:34:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:47233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263400AbTIGRde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:33:34 -0400
Date: Sun, 7 Sep 2003 10:34:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: piggin@cyberone.com.au, jyau_kernel_dev@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030907103447.410016f6.akpm@osdl.org>
In-Reply-To: <1062954122.12822.3.camel@boobies.awol.org>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
	<1062878664.3754.12.camel@boobies.awol.org>
	<3F5ABD3A.7060709@cyberone.com.au>
	<20030906231856.6282cd44.akpm@osdl.org>
	<1062954122.12822.3.camel@boobies.awol.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
>  There are a _lot_ of scheduler changes in 2.6-mm, and who knows which
>  ones are an improvement, a detriment, and a noop?

We know that sched-2.6.0-test2-mm2-A3.patch caused the regression, and
we now that sched-CAN_MIGRATE_TASK-fix.patch mostly fixed it up.

What we don't know is whether the thing which sched-CAN_MIGRATE_TASK-fix.patch
fixed was the thing which sched-2.6.0-test2-mm2-A3.patch broke.
