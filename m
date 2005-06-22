Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVFVUgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVFVUgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVFVUgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:36:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56239 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262215AbVFVUdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:33:51 -0400
Message-ID: <42B9CB29.5060303@pobox.com>
Date: Wed, 22 Jun 2005 16:33:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: libata-dev queue, ATA passthru updated
References: <42B9C616.9030101@pobox.com> <42B9C886.6010106@emc.com>
In-Reply-To: <42B9C886.6010106@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>>
>> I have updated the 'chs-support' and 'passthru' branches of
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to be current for the latest kernel.
>>
>> Additionally, I have uploaded the contents of the 'passthru' branch as 
>> a patch, at
>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.12-git4-passthru1.patch.bz2 
> 
> 
> 
> Wasn't T10 supposed to standardize passthru at the March meeting?  Any 
> idea when this can go mainstream?

Yes, T10 standardized things AFAIK.

However, there are outstanding reports that passthru causes device 
timeouts and other problems.  Investigating those, and a final review of 
the patch are all that's needed before passthru can go upstream.

	Jeff


