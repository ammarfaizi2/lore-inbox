Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbUL0NTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUL0NTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUL0NTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:19:35 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:39883 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261889AbUL0NTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:19:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and time drift
Date: Mon, 27 Dec 2004 08:19:14 -0500
User-Agent: KMail/1.7
Cc: Alexander Prokoshev <ap@insysnet.ru>
References: <41CFF1D9.6030104@insysnet.ru>
In-Reply-To: <41CFF1D9.6030104@insysnet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412270819.14458.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.45.252] at Mon, 27 Dec 2004 07:19:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 December 2004 06:28, Alexander Prokoshev wrote:
>Hello,
>
>  after installation of 2.6.10 kernel I've noticed time drift, which
>(according to ntpdc's dmpeer command) is about 10-15 seconds per
> hour. Downgrade to 2.6.9 solves this problem. I can send any
> additional information which may be helpful.

Until this gets fixed, you might try resetting the kernels tick period 
with the 'tickadj' command. I'm doing fairly well with a setting of 
9926 here, default is 10,000.  I stuck it in my rc.local file.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
