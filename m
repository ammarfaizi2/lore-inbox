Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWFYNpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWFYNpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWFYNpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:45:07 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:6279 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S1750911AbWFYNpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:45:05 -0400
Message-ID: <449E935E.4090006@tomt.net>
Date: Sun, 25 Jun 2006 15:45:02 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060622)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net> <449E770E.4010102@gmail.com>
In-Reply-To: <449E770E.4010102@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Andre Tomt wrote:
>> Tejun Heo wrote:
>>> Hello, all.
>>>
>>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
>>
>> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
>> patch, seems to be missing in drivers/scsi/Makefile:
> 
> Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
> updated tarball is at
> 
> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2 

Seems to work great so far, only knit is that the kernel log does not 
print it out the NCQ bits as indicated in the README. queue_depth in 
sysfs do show proper values however, just a backport issue I guess.
