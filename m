Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWCBCq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWCBCq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCBCq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:46:28 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5270 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750870AbWCBCq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:46:27 -0500
Message-ID: <44065C7C.6090509@pobox.com>
Date: Wed, 01 Mar 2006 21:46:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@gmail.com>
CC: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
       Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
In-Reply-To: <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>This also begs the question... what controller was being used, when the
>>single Maxtor device listed in the blacklist was added?  Perhaps it was
>>a problem with the controller, not the device.
>>
>>        Jeff
> 
> 
> As reported here:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951
> 
> the controller was a 3114, and the bug was "fixed" by blacklisting his
> Maxtor drive's FUA support.  I'd like Maxtor drives to be
> un-blacklisted if possible.

If its 3114 I agree un-blacklisting is the way to go... but its not 
clear to me whether the problematic configuration included sata_sil or 
sata_nv.  Since I'm apparently blind :) which part of the bug points 
conclusively to sata_sil?

	Jeff



