Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTLZUjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 15:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLZUjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 15:39:00 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:18332 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S265253AbTLZUi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 15:38:58 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: XFS filesystem corruption: 2.6.0. Massive failure. With raid5
Date: Fri, 26 Dec 2003 20:38:57 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bsi691$fkf$1@news.cistron.nl>
References: <1072425031.737.9.camel@osaka>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1072471137 16015 62.216.29.200 (26 Dec 2003 20:38:57 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1072425031.737.9.camel@osaka>,
Jerry Haltom  <jhaltom@feedbackplusinc.com> wrote:
>This has happened twice now. Massive XFS file system corruption. The
>system is running on a 3ware card in Raid5 config. / is XFS. Cannot
>mount:
>
>XFS: log has mismatchd uuid - can't recover
>XFS: failed to find log head
>XFS: log mount/recovery/failed
>...
>
>xfs_repair lets me know a lot of stuff, and:
>
>* ERROR: mismathced uuid in log
>* SB: some long number
>* log: a slightly different long number
>
>It doesn't work.
>
>xfs_logprint -t /dev/sda4 produces a lot of illegal type errors and ends
>up with Segmentation fault (uh oh).

I'm testing the same setup here right now, and you got me a bit worried..
If you know of a way to reproduce the bug, I can see if I can
replicate it on my hardware.

Mike.
-- 
When life hands you lemons, grab the salt and pass the tequila.

