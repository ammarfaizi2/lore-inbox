Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTJBNpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 09:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbTJBNpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 09:45:41 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263351AbTJBNpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 09:45:40 -0400
Subject: Re: 2.6.0-test6-mm2
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20031002022341.797361bc.akpm@osdl.org>
References: <20031002022341.797361bc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1065102332.10743.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Thu, 02 Oct 2003 09:45:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 05:23, Andrew Morton wrote:

> +show_task-on-runqueue.patch
> 
>  Teach sysrq-T to displayu which tasks actually have the CPU

This patch does:

	if (p->array)
		printk("has_cpu ");

does that work?  I think the existence of p->array is the same as it
being runnable.  It doesn't say whether or not it is actually running.

	Robert Love


