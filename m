Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbULDHAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbULDHAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 02:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbULDHAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 02:00:11 -0500
Received: from av6-2-sn2.hy.skanova.net ([81.228.8.107]:62676 "EHLO
	av6-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262533AbULDHAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 02:00:06 -0500
Date: Sat, 4 Dec 2004 08:00:04 +0100 (CET)
Message-Id: <200412040700.iB4704311162@d1o405.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-12-04 08:00:04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-03 23:08:55 Andrea Arcangeli wrote:

>You mean my patch is preventing your machine to boot? Then you're doing
>something else wrong because it's impossible my patch is preventing 
>your machine to boot.

Same experience as Thomas here. Full stop like his first log (no errors)
. PIII (Celeron) 900@1 gig, 256 meg mem, 1 gig swap, preempt enabled.

Tried your patch since the oom killer slaughtered a very important app 
here when another one ran amok. Not fork spawnings, just ram-eating. Was 
blender (3d renderer) in "Sequence Editor" mode when i hit alt-a (for 
animate) on a pretty large set of stills. Eventually blender got killed 
also, twice...

Kernel 2.6.9 with nick p-s? patch for the buggy kswapd (100 percent cpu, 
without using any swap).

Mvh
Mats Johannesson

