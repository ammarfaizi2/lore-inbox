Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVA2Uk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVA2Uk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 15:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVA2Uk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 15:40:28 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:32926 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261552AbVA2UkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 15:40:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
Date: Sat, 29 Jan 2005 15:40:19 -0500
User-Agent: KMail/1.7
Cc: ee21rh@surrey.ac.uk
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk> <pan.2005.01.29.13.02.51.478976@surrey.ac.uk> <9e473391050129112525f4947@mail.gmail.com>
In-Reply-To: <9e473391050129112525f4947@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291540.19667.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.42.183] at Sat, 29 Jan 2005 14:40:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 14:25, Jon Smirl wrote:
>On Sat, 29 Jan 2005 13:02:51 +0000, Richard Hughes 
<ee21rh@surrey.ac.uk> wrote:
>> On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
>> > Note, that strace glxgears gives exactly the same output, going
>> > from 0 to 14 and then seg-faulting, so it's *not just a oo
>> > problem*.
>>
>> I know it's bad to answer your own post, but here goes.
>>
>> I changed my /etc/udev/permissions.d/50-udev.permissions config to
>> read:
>>
>> dri/*:root:root:0666
>>
>> changing it from
>>
>> dri/*:root:root:0660
>>
>> And oowriter and glxgears work from bootup. Shall I file a bug
>> with udev?
>
>Your user ID needs to belong to group DRI.

Humm, scratching head here.  My /etc/group file contains no references 
to dri, but as root at least, it works just fine, X-6.8.1 here.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.32% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
