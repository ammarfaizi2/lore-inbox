Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVAZDL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVAZDL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 22:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVAZDL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 22:11:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:29348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262161AbVAZDLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 22:11:25 -0500
Date: Tue, 25 Jan 2005 19:10:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: arjan@infradead.org, trond.myklebust@fys.uio.no, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: make flock_lock_file_wait static
Message-Id: <20050125191050.68fb0cdf.akpm@osdl.org>
In-Reply-To: <20050125185812.GA1499@us.ibm.com>
References: <20050109194209.GA7588@infradead.org>
	<1105310650.11315.19.camel@lade.trondhjem.org>
	<1105345168.4171.11.camel@laptopd505.fenrus.org>
	<1105346324.4171.16.camel@laptopd505.fenrus.org>
	<1105367014.11462.13.camel@lade.trondhjem.org>
	<1105432299.3917.11.camel@laptopd505.fenrus.org>
	<1105471004.12005.46.camel@lade.trondhjem.org>
	<1105472182.3917.49.camel@laptopd505.fenrus.org>
	<20050125185812.GA1499@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
>  So, could the exports for the following symbols from the list please be
>  retained through December 31, 2005?
> 
>  	blk_get_queue
>  	sock_setsockopt
>  	vfs_follow_link
>  	__read_lock_failed
>  	__write_lock_failed

I don't think there's any plan to unexport any of these, and in most cases
it would be a dopey thing to do anyway.  And if we _were_ to try to remove
any of the above exports we should go through the
feature-removal-schedule.txt process.

So I think we're OK?
