Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTLQQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLQQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:41:26 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:60091 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S264451AbTLQQlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:41:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Thomas Voegtle <thomas@voegtle-clan.de>, linux-kernel@vger.kernel.org
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Date: Wed, 17 Dec 2003 11:41:18 -0500
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.21.0312171721420.32339-100000@needs-no.brain.uni-freiburg.de>
In-Reply-To: <Pine.LNX.4.21.0312171721420.32339-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312171141.18132.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.60.44] at Wed, 17 Dec 2003 10:41:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 December 2003 11:25, Thomas Voegtle wrote:
>On Wed, 17 Dec 2003, Gene Heskett wrote:
>> I take that it is attempting to scan all 8 addresses of the scsi
>> bus even though its actually hitting the atapi stuff?  Or do I
>> need an even fresher version of cdrecord? or libscg?
>
>Sorry, I shortend my output of cdrecord. With 2.6.0-test11 it looks
> like this:
>
>Using libscg version 'schily-0.7'
>scsibus0:
>cdrecord: Warning: controller returns wrong size for CD capabilities
> page. 0,0,0     0) 'CREATIVE' ' CD5233E        ' '2.05' Removable
> CD-ROM 0,1,0     1) 'PLEXTOR ' 'CD-R   PX-W1610A' '1.04' Removable
> CD-ROM 0,2,0     2) *
>        0,3,0     3) *
>        0,4,0     4) *
>        0,5,0     5) *
>        0,6,0     6) *
>        0,7,0     7) *

I see.  I also don't see the warning you are getting, and this may be 
the reason you can't burn.  I also do not have the normal cdrom as 
device 0.  What happens if you swap the master/slave jumpers and put 
the recorder first?  It might be worth a try, and any changes in how 
it works would be a clue as to where the real stoppage is.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

