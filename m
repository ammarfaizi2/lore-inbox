Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUIYShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUIYShj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUIYShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:37:39 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:20978 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S269377AbUIYShV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:37:21 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3 breaks amanda (was: 2.6.9-rc2-mm3)
Date: Sat, 25 Sep 2004 14:37:16 -0400
User-Agent: KMail/1.7
Cc: Matthias Andree <matthias.andree@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <20040924014643.484470b1.akpm@osdl.org> <20040925172223.GA14562@merlin.emma.line.org>
In-Reply-To: <20040925172223.GA14562@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409251437.17017.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.62.98] at Sat, 25 Sep 2004 13:37:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 September 2004 13:22, Matthias Andree wrote:
>On Fri, 24 Sep 2004, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.
>>9-rc2/2.6.9-rc2-mm3/
>>
>> - This is a quick not-very-well-tested release - it can't be worse
>> than 2.6.9-rc2-mm2, which had a few networking problems.
>
>Some problems appear to persist (and have also haunted earlier -mm
>versions of 2.6.9-rc2, haven't checked older -mm recently)
>
>When running an Amanda (network backup) server with a 2.6.9-rc2-mm3
>kernel, the backup size estimates pass properly but no backup data
> is recevied from remote Amanda clients, only local backups are
> made.
>
>I understand too little of the exact Amanda protocol to tell more,
>vanilla 2.6.7 was fine though.

Sounds to me as if amanda isn't setup correctly.  its working here 
just fine with 1 server and 2 clients, one of which is the server 
itself.  Running version 2.4.5b1-20040915 to virtual tapes on a big 
disk.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
