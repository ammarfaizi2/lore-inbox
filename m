Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTKIGuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 01:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTKIGuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 01:50:09 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:21995 "EHLO
	omta10.mta.everyone.net") by vger.kernel.org with ESMTP
	id S262196AbTKIGuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 01:50:07 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Sat, 8 Nov 2003 22:50:00 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: RFC:  (WIP) FoxFS File System
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20031109065000.317E7AC06@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm nearing the very end of my expertise here.  I'll be finishing out the Inode List format and polishing the Superblock handling.  After that I'll need to pick up some help for Quota Acceleration and for putting the final polish on the system.  If properly maintained (defragmented, assembled Inode Lists, contiguated free space), it should be fast.  Metajournaling-- a similar if not identical (I haven't researched it much) concept to what ReiserFS and ext3 use--should be especially useful on floppies and other small media with a journal (4K journal would be quite enough).

Any thoughts?  i'm lazy so it'll be a while before the specs are ready for coding.  Please CC replies directly to me.

--Bluefox Phoenix Lucid

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
