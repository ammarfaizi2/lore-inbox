Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTIDRal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbTIDRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:30:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265337AbTIDRah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:30:37 -0400
Date: Thu, 4 Sep 2003 10:13:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: disk I/O hang in 2.6.0-test4-mm5
Message-Id: <20030904101339.1d67f616.akpm@osdl.org>
In-Reply-To: <20030904171626.GA26054@osdl.org>
References: <20030904171626.GA26054@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
> I'm seeing a mkfs.ext2 that never completes under 2.6.0-test4-mm5.
> I ran 4 mkfs.ext2's concurrntly, each on a seperate partition on the
> same disk.  Three of the completed.  Here's the sysrq stack trace from
> the one that didn't.
> 
> This doesn't occur on mm4.

Could you please revert

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/broken-out/elv-insertion-fix.patch

and retest?
