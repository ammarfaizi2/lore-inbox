Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUISWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUISWjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUISWjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:39:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:9093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264726AbUISWjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:39:01 -0400
Date: Sun, 19 Sep 2004 15:36:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-Id: <20040919153648.105103b5.akpm@osdl.org>
In-Reply-To: <20040919214649.GA8443@elte.hu>
References: <200409192232.20139.annabellesgarden@yahoo.de>
	<20040919214649.GA8443@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  > Could you
>  > please include the swapspace-layout-improvements in the
>  > voluntary-preempt patches?
> 
>  only if Andrew agrees that the patch has a chance for -mm inclusion and
>  possible upstream merging.

It needs more work - from the (brief) testing I did, it didn't seem to
improve that which it was intended to improve: swap I/O performance.  Not
sure why, really.

The latency improvements were serendipitous.

