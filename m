Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWHMAp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWHMAp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWHMAp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:45:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932630AbWHMAp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:45:57 -0400
Date: Sat, 12 Aug 2006 17:45:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: softirq considered harmful
Message-Id: <20060812174549.9a8f8aeb.akpm@osdl.org>
In-Reply-To: <20060812.174324.77324010.davem@davemloft.net>
References: <20060810110627.GM11829@suse.de>
	<20060812162857.d85632b9.akpm@osdl.org>
	<20060812.174324.77324010.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 17:43:24 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Sat, 12 Aug 2006 16:28:57 -0700
> 
> > Maybe I missed the discussion.  But if not, this is yet another case of
> > significant changes getting into mainline via a git merge and sneaking
> > under everyone's radar.
> 
> Scsi has been doing command completions via a per-cpu softirq handler
> for as long as we've had an SMP more advanced than lock_kernel() :-)

Is that also adding 150 usecs to each IO operation?

