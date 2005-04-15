Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVDOOI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVDOOI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVDOOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:08:26 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:6330 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261822AbVDOOIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:08:21 -0400
Subject: Re: [GIT PATCH] scsi updates for 2.6.12-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050415112556.GA6086@elf.ucw.cz>
References: <1113442034.4933.53.camel@mulgrave>
	 <20050415103646.GB1797@elf.ucw.cz>  <20050415112556.GA6086@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 09:08:03 -0500
Message-Id: <1113574084.5009.1.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 13:25 +0200, Pavel Machek wrote:
> Okay, so du -s is:
> 
> root@amd:~# du -sh /tmp/delme.git/
> 109M    /tmp/delme.git/
> 
> Not as bad as I expected, but still quite a lot of data for few
> changes.

Erm, but that's why it's an rsync archive.  You're supposed to have a
copy of the kernel archive already.  The one at

rsync://www.kernel.org/pub/linux/kernel/people/torvalds/kernel-test.git

Then, the few additional files I have rsync across very fast.

Take a look at how git works:  files, once added to the object tree by
sha1 hash stay there forever.

James


