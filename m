Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWJBRD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWJBRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWJBRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:03:56 -0400
Received: from king.bitgnome.net ([70.84.111.244]:58082 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S932532AbWJBRDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:03:55 -0400
Date: Mon, 2 Oct 2006 12:03:54 -0500
From: Mark Nipper <nipsy@bitgnome.net>
To: linux-kernel@vger.kernel.org
Subject: kernel: pageout: orphaned page with reiserfs v3 in data=journal mode under 2.6.18
Message-ID: <20061002170353.GA26816@king.bitgnome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        I saw this in my logs earlier today:
---
kernel: pageout: orphaned page

        It's the first time I've seen it on this box, but I also
just switched to data=journal mode for all of my reiserfs mounts
yesterday after a hard drive died in a software RAID-1 volume
(which incidentally caused some thankfully repairable file system
damage after a --rebuild-tree seemingly because even though the
hard drive which was failing was reporting uncorrectable errors
to the kernel, the software RAID system never failed the drive
out of the volume but instead kept trying to use it).

        Anyway, just wondering if the message is bad actually as
in it indicates some memory leak will bring down my server at
some point or if it's just a corner case which someone felt the
need to document whenever it happens.

        I'm no longer subscribed to the list, so please keep this
in mind if you reply.  Thanks.

-- 
Mark Nipper                                                e-contacts:
4320 Milam Street                                   nipsy@bitgnome.net
Bryan, Texas 77801-3920                     http://nipsy.bitgnome.net/
(979)575-3193                      AIM/Yahoo: texasnipsy ICQ: 66971617

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
I cannot tolerate intolerant people.
----end random quote of the moment----
