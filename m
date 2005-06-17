Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVFQQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVFQQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVFQQ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:29:27 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39578 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262011AbVFQQ3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:29:23 -0400
Subject: Re: [patch] inotify, improved.
From: Robert Love <rml@novell.com>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Friesen <cfriesen@nortel.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au>
	 <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy>
	 <42B2EE31.9060709@nortel.com> <1119023078.3949.115.camel@betsy>
	 <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 12:29:25 -0400
Message-Id: <1119025765.3949.118.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 12:11 -0400, Valdis.Kletnieks@vt.edu wrote:

> It's also racy as hell.  By the time the inotify gets delivered to the
> userspace process, pid 820 may be long gone.....

Yah, no one would expect otherwise.  One nice feature of it would be
able to see if the pid is equal to a known pid, say yourself or some
worker process.

But I've also received requests to send the size and offset of a
read/write, the user, etc. etc.  I just say no.

	Robert Love


