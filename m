Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTK0PPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTK0PPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:15:51 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:45820 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S264536AbTK0PPu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:15:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Akinobu Mita <mita@miraclelinux.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [BUG 2.4] NFS unlocking operation accesses invalid file struct
Date: Thu, 27 Nov 2003 10:15:47 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200311252000.32094.mita@miraclelinux.com> <shs1xrwvudw.fsf@charged.uio.no> <200311272054.22316.mita@miraclelinux.com>
In-Reply-To: <200311272054.22316.mita@miraclelinux.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311271015.47746.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 09:15:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 06:54, Akinobu Mita wrote:

>From somebody trying to learn something here.

Unpatched 2.6.0-test11 here, using anticipatory scheduler

What should I expect to see occuring when this is executed?

Here, after a few initial cycles of the numbers getting larger, then 
stepping smaller and restarting the rise, eventually (a minute or so) 
the numbers started to rise and never stopped till I killed it.
The first 2 numbers always matched, and a much smaller pair near the 
end of the line always matched, the first pair being something above 
30,000 when I stopped it after about 2 1/2 minutes.

>Thanks, Trond.
>
>but, your patch causes memory leak.

[snip code]

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

