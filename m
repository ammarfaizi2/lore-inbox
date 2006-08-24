Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWHXXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWHXXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 19:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWHXXm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 19:42:57 -0400
Received: from ozlabs.org ([203.10.76.45]:61397 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030409AbWHXXm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 19:42:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.14556.535277.434642@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 09:40:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] dubious process system time.
In-Reply-To: <20060824121825.GA4425@skybase>
References: <20060824121825.GA4425@skybase>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky writes:

> The system time that is accounted to a process includes the time spent
> in three different contexts: normal system time, hardirq time and
> softirq time.

Is that true (at the moment) with CONFIG_VIRT_CPU_ACCOUNTING=y?  I
thought it wasn't.

Paul.
