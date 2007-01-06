Return-Path: <linux-kernel-owner+w=401wt.eu-S1751168AbXAFEBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbXAFEBW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbXAFEBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:01:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56479 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbXAFEBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:01:21 -0500
Date: Fri, 5 Jan 2007 19:59:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       kernel@bardioc.dyndns.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-Id: <20070105195911.37c40e94.akpm@osdl.org>
In-Reply-To: <368051775.16914@ustc.edu.cn>
References: <368051775.16914@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 10:50:02 +0800
Fengguang Wu <fengguang.wu@gmail.com> wrote:

> Jens: can this be a plugging issue?
> 
> The following command seems to block for ever:
> # mount /home
> 
> It is an ext3 fs on top of /dev/md0, RAID1.

http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically 2.6.20-rc3-mm1,
minus git-block.patch.  Can you and Torsten please test that, see if the hangs
go away?

Thanks.
