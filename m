Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUIQJAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUIQJAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIQJAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 05:00:41 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:55819 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S268534AbUIQJAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 05:00:40 -0400
From: Meelis Roos <mroos@linux.ee>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
In-Reply-To: <20040917084302.GA2911@suse.de>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.9-rc2n (i686))
Message-Id: <E1C8Ebe-0000rf-75@rhn.tartu-labor>
Date: Fri, 17 Sep 2004 12:00:38 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JA> Exactly the same issue, read the thread - your tray is locked, because
JA> someone else has the drive open.

In my case it's kscd thats' keeping the device open. kscd is in D state,
wchan is ide_do_drive_cmd.

Perhaps it's in D state because I once forced the CD open using cdrecod
-eject.

-- 
Meelis Roos
