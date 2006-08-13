Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWHMBJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWHMBJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 21:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWHMBJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 21:09:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21123
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932641AbWHMBJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 21:09:25 -0400
Date: Sat, 12 Aug 2006 18:09:44 -0700 (PDT)
Message-Id: <20060812.180944.51301787.davem@davemloft.net>
To: akpm@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060812174549.9a8f8aeb.akpm@osdl.org>
References: <20060812162857.d85632b9.akpm@osdl.org>
	<20060812.174324.77324010.davem@davemloft.net>
	<20060812174549.9a8f8aeb.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 12 Aug 2006 17:45:49 -0700

> Is that also adding 150 usecs to each IO operation?

I have no idea, Jens hasn't done enough to narrow down the true cause
of the latencies he is seeing.  So pinpointing it on anything specific
is highly premature at this stage.

My point was merely to encourage you to find out the facts before
tossing accusations around. :-) I/O completions via softirqs aren't
some new thing, in general, as the SCSI example shows, and GIT didn't
even exist when the scsi command completion via softirq changes went
in.

Heck I think even Eric Youngdale was still an active developer of our
SCSI stack back then, that's a long time ago! :-)
