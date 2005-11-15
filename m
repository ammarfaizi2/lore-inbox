Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVKOCOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVKOCOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVKOCOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:14:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62879 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932219AbVKOCOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:14:10 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <437933B6.1000503@shaw.ca>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>
	 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>
	 <58UQf-6Da-3@gated-at.bofh.it>  <437933B6.1000503@shaw.ca>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 21:07:48 -0500
Message-Id: <1132020468.27215.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 19:02 -0600, Robert Hancock wrote:
> Giridhar Pemmasani wrote:
> > Shouldn't I have to prevent scheduler from changing the tasks when executing
> > Windows code? Otherwise, kernel gets wrong current thread information,
> > which is based on stack pointer. This is the stumbling block for implementing
> > private stacks.
> 
> As long as preemption is disabled when the driver code is executing

Um, but it's really really bad for drivers to do that.

Lee

