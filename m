Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266557AbUBQUtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUBQUtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:49:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:18872 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266557AbUBQUs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:48:59 -0500
Date: Tue, 17 Feb 2004 12:50:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: rusty@rustcorp.com.au, steiner@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce TLB flushing during process migration
Message-Id: <20040217125038.14396a1d.akpm@osdl.org>
In-Reply-To: <20040217154926.GI12142@localhost>
References: <20040217154926.GI12142@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@wildopensource.com> wrote:
>
> Another optimization patch from Jack Steiner, intended to reduce TLB
> flushes during process migration.

This patch is only applicable to CONFIG_NUMA.  Wouldn't SMP systems benefit
from the same treatment?

And does this optimisation come with any benchmark results?

Thanks.
