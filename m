Return-Path: <linux-kernel-owner+w=401wt.eu-S1754825AbWL1LEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbWL1LEM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbWL1LEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 06:04:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49547 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831AbWL1LEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 06:04:11 -0500
Date: Thu, 28 Dec 2006 03:03:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Fengguang Wu <fengguang.wu@gmail.com>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-Id: <20061228030346.6ea46d01.akpm@osdl.org>
In-Reply-To: <20061228104508.GA20596@flint.arm.linux.org.uk>
References: <1167275845.15989.153.camel@ymzhang>
	<20061227194959.0ebce0e4.akpm@osdl.org>
	<367290328.14058@ustc.edu.cn>
	<20061228022926.4287ca33.akpm@osdl.org>
	<20061228104508.GA20596@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 10:45:08 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The kernel community needs to get a grip with the implementation of
> new syscalls - we need a process where architecture maintainers get
> to review the arguments _prior_ to them being accepted into the kernel.
> That way we can avoid silly architecture specific syscall changes like
> this.

hm, well, actually, sys_fadvise64_64 was discussed on linux-arch when
it went in. 

(Gad, it was over three years ago! - glibc support should be pretty widespread
now)

That's about as much discussion as these things will get.  And this assumes
that people remember to mention it.  Mental note made.
