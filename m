Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUFPV3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUFPV3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUFPV33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:29:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:43925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266310AbUFPV3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:29:19 -0400
Date: Wed, 16 Jun 2004 14:30:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Message-Id: <20040616143040.403bf68b.akpm@osdl.org>
In-Reply-To: <20040616142413.GA5588@sgi.com>
References: <20040616142413.GA5588@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> In the process of testing per/cpu interrupt response times and CPU availability,
> I've found that running cache_reap() as a timer as is done currently results
> in some fairly long CPU holdoffs.

Before patching anything I want to understand what's going on in there. 
Please share your analysis.


How long?

How many objects?

Which slab?

Why?

Thanks.
