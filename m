Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUJADRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUJADRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 23:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbUJADRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 23:17:46 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:63213 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S269672AbUJADRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 23:17:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 23:17:42 -0400
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>, Clemens Schwaighofer <cs@tequila.co.jp>,
       "Markus T." <markus@trippelsdorf.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <200409301627.20548.gene.heskett@verizon.net> <415C80C1.8070406@pobox.com>
In-Reply-To: <415C80C1.8070406@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409302317.42071.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 22:17:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 17:55, Jeff Garzik wrote:
>Gene Heskett wrote:
>> bz2 has resulted in corrupted unpacks here on more than one
>> occasion, and it has done it without any outwardly visible error
>> when the md5sum was good.  I've had it skip a whole subdir tree in
>> a kernel unpack on at least 4 occasions, and a missing file
>> someplace on several more occasions.  I don't have any such
>> troubles when dl'ing and using the .gz version of things.
>>
>> There has been at least one occasion where the .bz2 dl had a bad
>> md5sum, again without any visible error as it was downloading,
>> nuke it and go back and get the same file again and it was good. 
>> Again I've had no such troubles when using the .gz versions, so
>> after a a while, I got into the habit of just gettng the .gz
>> version and I've never had an instance of a bad md5sum that wasn't
>> accompanied by site access problems.
>
>There's definitely something else going on.  I don't see how you can
>blame bz2 for downloading problems.  If this were true we would see
> a _lot_ more problem reports than just one in >5 years.
>
> Jeff

Just one in 5 years, the one being me?  Not really Jeff.  Someplace in 
this lists archives is a squawk from me dating back maybe 2 years, 
detailing that I had to go download such and such a kernel from 
kernel.org repeatedly (I think it as 3 times, on a dialup circuit) 
before the unpack gave me a certain subdir in the tree and the -mm 
patch upchucked over missing src files it wanted to patch.  At that 
time IIRC, someone suggested I use the .gz's and I've had no further 
problems.  Whomever made the suggestion semi-indicated that what I 
was seeing wasn't unknown to the responder.  Not in so many words 
mind you, but the general tone of the message sure said it.

I also got bummed a couple of times back in the very early days of bz2 
because it beat the amiga's default .lha compression quite a bit.  
But it didn't always work.  IIRC there was a flurry of bz2 
development 2-3 years back, and maybe thats no longer true.  Me, I 
don't fix what isn't broken, so I get the .gz's only.  On dsl it 
doesn't hurt so much. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
