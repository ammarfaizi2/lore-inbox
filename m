Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUHWIxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUHWIxm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 04:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUHWIxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 04:53:41 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:8877 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S267552AbUHWIxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 04:53:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: IEEE-1588
Date: Mon, 23 Aug 2004 04:53:35 -0400
User-Agent: KMail/1.6.82
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-net@vger.kernel.org
References: <Pine.OSF.4.05.10408230950290.29749-100000@da410.ifa.au.dk>
In-Reply-To: <Pine.OSF.4.05.10408230950290.29749-100000@da410.ifa.au.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408230453.35598.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.62.54] at Mon, 23 Aug 2004 03:53:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 August 2004 03:51, Esben Nielsen wrote:
>Does anyone know about that standard for time syncronization? Is
> there any work on Linux-support?
>
>Esben

Sure.  There is ntpdate, intended for gross corrections at boot time, 
and ntp, which finetunes things if you need microsecond accuracy all 
day long.  I don't, so I just run ntpdate at boot time and 4x a day 
with cron against 4 servers chosen at random from a list of 33, using 
a script and a list of servers someone posted years ago now.

Both are installed in a normal full install, but not this script.  ntp 
as I understand it needs configured before its used, but it can be 
run from /etc/init.d by turning it on with chkconfig once its 
configured.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
