Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263205AbUD0EuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUD0EuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUD0EuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:50:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:33953 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263205AbUD0EuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:50:17 -0400
Date: Mon, 26 Apr 2004 21:49:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.6-rc2 Allow architectures to reenable interrupts on
 contended spinlocks
Message-Id: <20040426214952.333c9ad7.akpm@osdl.org>
In-Reply-To: <1928.1083031191@kao2.melbourne.sgi.com>
References: <1928.1083031191@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
>  Enable interrupts while waiting for a disabled spinlock, but only if
>  interrupts were enabled before issuing spin_lock_irqsave().  It makes a
>  measurable difference to interrupt servicing on large systems.

Do you know which are the offending locks?

How much difference, and how large are the systems?

Thanks.
