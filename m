Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbULZQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbULZQMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbULZQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:12:22 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:40133 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261689AbULZQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:12:19 -0500
Subject: Re: lease.openlogging.org is unreachable
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 10:12:10 -0600
Message-Id: <1104077531.5268.32.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The interesting thing is that the code already has a backup in it and I just
> checked that code path and it works.
> 
> Has anyone else been shut down because of lease.openlogging.org being down
> and if so what version of BK were you running please?

I believe I've reported this problem to you and support@bitmover.com
several times.

There's something in BK that refuses to work when it can't contact
lease.openlogging.org, regardless of whether you just renewed the lease
or not.  This keeps biting me when I try to use BK disconnected from the
internet (usually while travelling).

This problem is certainly my single biggest headache with BK since it
means I can't go through my backlog of email and build the SCSI BK tree
when I'm travelling (which is often the only time I have available for
doing it).

My current version is bk 3.2.3 but it's been a problem on all prior
versions I've used as well.

James


