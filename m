Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUKDOMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUKDOMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUKDOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:12:52 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:44459 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262231AbUKDOLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:11:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 09:11:51 -0500
User-Agent: KMail/1.7
Cc: Doug McNaught <doug@mcnaught.org>, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040739.01699.gene.heskett@verizon.net> <87wtx1220n.fsf@asmodeus.mcnaught.org>
In-Reply-To: <87wtx1220n.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040911.51923.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.11.139] at Thu, 4 Nov 2004 08:11:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 08:10, Doug McNaught wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> [root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config
>> CONFIG_MAGIC_SYSRQ=y
>
>Did you also enable it in /proc?
>
>-Doug

I just now discovered it defaults to a 0, so I put an 
echo 1 >proc/sys/kermel/sysrq
in rc.local just now.

Thanks for the heads up.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
