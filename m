Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTLTAQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTLTAQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:16:45 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:16326 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263702AbTLTAQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:16:43 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: SCSI AM53C974 driver missing in 2.6.0?
Date: Fri, 19 Dec 2003 19:16:38 -0500
User-Agent: KMail/1.5.1
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0312192210550.3888-100000@poirot.grange>
In-Reply-To: <Pine.LNX.4.44.0312192210550.3888-100000@poirot.grange>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191916.38901.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.60.44] at Fri, 19 Dec 2003 18:16:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 16:16, Guennadi Liakhovetski wrote:
>On Fri, 19 Dec 2003, Randy.Dunlap wrote:
>> On Thu, 18 Dec 2003 15:55:27 +0100 Ralf Hildebrandt 
<Ralf.Hildebrandt@charite.de> wrote:
>> | in 2.4.x we've been using
>> | CONFIG_SCSI_AM53C974=m
>> |
>> | 2.6.0 doesn't seem to have any support for that specific SCSI
>> | controller. What now? Aternatives?
>>
>> Kurt Garloff <garloff@suse.de>
>> and Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> have made some recent patches for this driver.
>> It was discussed on the linux-scsi@vger.kernel.org mailing list.
>
>tmscsim driver should be used in 2.6. I've posted the "final"
> version of a patch to this driver on linux-scsi. Kurt wanted to put
> it on his site for download, so, maybe it's there. Otherwise have a
> look in linux-scsi archives. It should be included in 2.6 at some
> point, possibly, 2.6.1...

Hey, how about us advansis users?  There is at least one, me...  And 
thats the only driver in the whole compile that spits out visible 
warnings about check_region() being deprecated.  But its still 
working, so far.  I presume it will until such time as check_region() 
is actually removed from wherever it lives.

>Guennadi
>
>P.S. heh, this is becomming a FAQ:-)) Looks like there are a couple
> more users of this driver / chip then I initially thought:-)
>---
>Guennadi Liakhovetski

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

