Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUGVUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUGVUnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUGVUnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:43:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29646 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261602AbUGVUm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:42:58 -0400
Subject: Re: [Q] claimed block devices
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: christophe.varoqui@free.fr
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090511685.40ffe345f252b@imp6-q.free.fr>
References: <1090489874.40ff8e1226ad0@imp6-q.free.fr>
	 <1090499383.17489.39.camel@shaggy.austin.ibm.com>
	 <1090511685.40ffe345f252b@imp6-q.free.fr>
Content-Type: text/plain
Message-Id: <1090512809.17489.59.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jul 2004 11:13:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 10:54, christophe.varoqui@free.fr wrote:
> if I read fs/block_dev.c correctly, O_EXCL will always fail on block device.

In blkdev_open()?  If O_EXCL is set, the result will depend on whether
or not bd_claim() succeeds.

> I would also like to use the lock owner information ... which seems even more
> tricky.

I don't have any suggestions here.  :^(

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

