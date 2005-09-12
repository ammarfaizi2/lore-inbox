Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVILBcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVILBcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 21:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVILBcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 21:32:18 -0400
Received: from quechua.inka.de ([193.197.184.2]:46286 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751123AbVILBcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 21:32:17 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: read-from-all-disks support for RAID1?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <17188.52623.351989.468493@cse.unsw.edu.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1EEdB9-000374-00@calista.inka.de>
Date: Mon, 12 Sep 2005 03:32:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <17188.52623.351989.468493@cse.unsw.edu.au> you wrote:
> However, I'm not 100% certain that WV would really be useful.  Modern
> drives will almost certainly return a read-after-write request out of
> the drive's cache rather than going to the media.  We would need some
> way to tell the drive to ignore the cache for this read.  I suspect
> this is possible, but might not be trivial...

I too think an background disk scrubbing job to detect bit errors
(expecially usefull for raid5, but also helpfull todetect bad hardware)
would be good. Some user mode API is needed to address parts of mirrors or
parity sets.

Gruss
Bernd
