Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUEVIMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUEVIMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEVIMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:12:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:48097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264911AbUEVIMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:12:12 -0400
Date: Sat, 22 May 2004 01:11:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3 barrier bits
Message-Id: <20040522011139.01a7da10.akpm@osdl.org>
In-Reply-To: <20040522073540.GO1952@suse.de>
References: <20040521093207.GA1952@suse.de>
	<20040521023807.0de63c7a.akpm@osdl.org>
	<20040521100234.GK1952@suse.de>
	<20040521235044.6160cccb.akpm@osdl.org>
	<20040522073540.GO1952@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


May as well cc lkml on this.  It's to do with the disk write barrier
implementation.


- How do I know that the barrier code is actually doing stuff?  It doesn't
  seem to affect benchmarks much, if at all.

- Does reiserfs support `mount -o remount,barrier=flush'? and "=none"?

- How do I test the "oh, barriers aren't working" fallback code in ext3?

- Does the kernel tell you if your disk doesn't supoprt barriers?  ie:
  how does the user know if it's working or not?

