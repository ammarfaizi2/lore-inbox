Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbULHWxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbULHWxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbULHWxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:53:24 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:8446 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S261399AbULHWxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:53:18 -0500
Date: Wed, 8 Dec 2004 14:11:23 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Mach Speed motherboard w/onboard video
In-Reply-To: <200412081248.57255.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0412081409350.14310@twin.uoregon.edu>
References: <200412081140.33199.gene.heskett@verizon.net>
 <1102525014.30593.17.camel@krustophenia.net> <200412081248.57255.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004, Gene Heskett wrote:

> On Wednesday 08 December 2004 11:56, Lee Revell wrote:
>> On Wed, 2004-12-08 at 11:40 -0500, Gene Heskett wrote:
>>> Has a builtin video, called UniCrome in the propaganda.
>>>
>>> Are there usable linux drivers for this one?
>>
>> Yes, they are quite good actually:
>>
>> http://unichrome.sourceforge.net/
>>
>> The biggest problem is that the via DRM module is not in the kernel
>> yet. You will have to install it from dri.sourceforge.net CVS.  It
>> was in a recent -mm release but was dropped and unfortunately the
>> current version doesn't work with the -mm kernel.  Andrew Morton &
>> others have said they will try to get it back in soon.
>>
>> Lee
>
> Unforch, this implies its for 2.6 kernels.  The machine in question
> will be running 2.5.25-adeos, an rtai conversion kernel.  I'll take a
> look and see if it might be buildable for that.  Thanks for the links.

If you don't care much about video performance the via embedded video 
works fine for most applications... it's derived from their s3 aquisition.


>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

