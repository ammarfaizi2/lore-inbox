Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUBYBCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbUBYBBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:01:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:56746 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262551AbUBYBBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:01:45 -0500
Date: Tue, 24 Feb 2004 17:03:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reaim - 2.6.3-mm1 IO performance down.
Message-Id: <20040224170337.798f5766.akpm@osdl.org>
In-Reply-To: <20040224162052.33895550.cliffw@osdl.org>
References: <20040224162052.33895550.cliffw@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> For the same test on the same machine, results from 2.6.2-rc1-mm2 and 2.6.2-rc3-mm1
> were within 1.0% of the linux-2.6.2 runs. So this is new. 
> 
> More data and tests if requested - are there some patch sets we should try reverting?

Thanks.  You could try reverting adaptive-lazy-readahead.patch.  If it is
not that I'd be suspecting CPU scheduler changes.  Do you have uniprocessor
test results?


