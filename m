Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbULPCMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbULPCMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbULPCIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:08:22 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:61158 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262603AbULPCD5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:03:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Wed, 15 Dec 2004 21:03:49 -0500
User-Agent: KMail/1.7
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>
References: <20041213002751.GP16322@dualathlon.random> <200412151203.44679.gene.heskett@verizon.net> <Pine.LNX.4.53.0412151846370.27011@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0412151846370.27011@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412152103.49174.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 20:03:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 12:48, Tim Schmielau wrote:
>> Ok, I was going to do that, but forgive me, its not in the .config
>> file as a setting.  So where do edit what to revert to 100hz's.
>
>It's in line 5 of include/asm-i386/param.h:
># define HZ             1000            /* Internal kernel timer
> frequency */
>
>(if you are on an i386 system). Just change that back to 100.
>
>Tim

Thanks Tim, I might do that for a boot or 2 just for the exersize.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

