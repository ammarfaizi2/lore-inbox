Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbVJCVx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbVJCVx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVJCVx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:53:58 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29707 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932702AbVJCVx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:53:58 -0400
Message-ID: <4341A880.3060000@tmr.com>
Date: Mon, 03 Oct 2005 17:54:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: jmerkey <jmerkey@utah-nac.org>, Nuno Silva <nuno.silva@vgertech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org> <43415D14.5070909@tmr.com> <43419D0C.4010002@rtr.ca>
In-Reply-To: <43419D0C.4010002@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Bill Davidsen wrote:
> 
>>
>> It would be great to have some way to match drives with names, but 
>> there doesn't seem to be a single solution for PATA, SATA, SCSI and 
>> hotplug. Something like mounts using UUID of the filesystem, but for 
>> the drives.
> 
> 
> I believe it would be pretty easy for userspace hotplug scripts
> (udev and pals) to assign drives names by matching model/serialno,
> if that's what you had in mind.

That's the functionality I have in mind, the problem is finding the 
model and serial number info for all the various types. In some "really 
works" plug and play world there would be software to generate something 
like the UUID, and a nice table of what to call it. That doesn't quite 
seem to be the case yet, and it makes life a bit dificult if you need 
raw partitions on plugable devices.

Not impossible, but PITA right now. Anyone looking for a topic for their 
thesis? ;-)
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
