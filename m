Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUBQKMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 05:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUBQKMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 05:12:46 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:46123 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264565AbUBQKMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 05:12:43 -0500
Date: Tue, 17 Feb 2004 02:13:15 -0800
From: Paul Jackson <pj@sgi.com>
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove obsolete onstream support from ide-tape in
 2.6.3-rc3
Message-Id: <20040217021315.14ca7a9a.pj@sgi.com>
In-Reply-To: <c0rmfa$453$1@gatekeeper.tmr.com>
References: <20040215221108.GA4957@serve.riede.org>
	<20040215153214.002dcc9a.pj@sgi.com>
	<c0rmfa$453$1@gatekeeper.tmr.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but can't read anything more than about a decade old.

Yes.  One has to abandon the idea that offline storage is archival.
It's just for disaster recovery.  Archive online.  Backup to removable
disk, or, if you're Linus, everyone else's computer ;).

I keep everything I've ever done that I might ever want to see again
(DOS, Warp, Win, Irix, Linux, ...) on one disk, my current disk.  It
gets copied over, and appended to.

If it's not on that disk or its backups, it no longer exists.

Backups, now on removable IDE drives, only have to last a year or so, in
case I didn't realize something was missing for a while.

I'm working on a disk-to-disk backup program that is a radical departure
from existing backups.  It maintains a single version controlled ascii
line oriented master list file, and plain copies of the backed up files,
exactly one such copy per unique md5sum.  It handles 50 Gbytes in 30
minutes (300+ files per second).  186 lines of Python.  No tar, no cpio,
no compression, no binary file formats, no streaming media; trivial and
robust.

The economics of backup and archiving have changed, with the continuing
rapid decline in dollars/bytes of online storage.

New strategies are called for.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
