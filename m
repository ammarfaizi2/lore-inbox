Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUHIQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUHIQWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUHIQWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:22:24 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:32452 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266684AbUHIQWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:22:22 -0400
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF09020F@piramida.hermes.si>
References: <B1ECE240295BB146BAF3A94E00F2DBFF09020F@piramida.hermes.si>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <528D860E-EA20-11D8-8DDF-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: Can not read UDF CD
Date: Mon, 9 Aug 2004 10:22:35 -0600
To: David Balazic <david.balazic@hermes.si>
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 09 Aug 2004 16:22:21.0056 (UTC) FILETIME=[0BD82800:01
	C47E2D]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:2.34993 C:20 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried session=0.
> This gives me the files form the first session, but I can only list 
> them.
> I can not see their attributes ( size, permissions etc.. ) or read 
> them.

This sounds exactly like the known bug, shared by 2.6.6 and 2.6.5, 
fixed in 2.6.7, described previously as occurring for UDF discs written 
to Linux from Windows:

ls works, but ls -l does not and cd does not.

> other session=x values fails to mount.

The dmesg for session=1 might interest us, but in any case, I vote we 
try reasonably current code e.g. 2.6.7 or a cvs fetch of UDF.

> I put the ISO image and the udf checker outputs on BitTorrent,
> the torrent file is avaliable at
> http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent

Excellent, now in theory I can try this myself.

> In case you don't have a BitTorrent client, one can be had at
> http://bitconjurer.org/BitTorrent/download.html
> ( even a commandline version , written in python )

In practice I am not yet a BitTorrent client, thanks for this clear 
invitation.

>> Re: potential bug in udf
>> ... a new bug ...
> Upgraded to 2.6.7 - the problem is still there.

I hear 2.6.7 is by now old enough to have begun collecting known bugs.

Pat LaVarre

