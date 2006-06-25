Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWFYNss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWFYNss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWFYNss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:48:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:59910 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750956AbWFYNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:48:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RQQIqiFkfkjewCyBWl8Rsrq7mJagEh3RGXxOtV31PT2fFRp7v7nMNomGa8Q9uTFfp7Qzi8cgMuOmooRNYotPUAO8kz76F0DLraeMuwOcApvIoAtSgfbJWJ2ffTel2IOgjCZs7Gm9LNhW5OqZotniEToCmiiIqejTbqeiSms9kY0=
Message-ID: <449E943C.4050706@gmail.com>
Date: Sun, 25 Jun 2006 22:48:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net> <449E770E.4010102@gmail.com> <449E935E.4090006@tomt.net>
In-Reply-To: <449E935E.4090006@tomt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Tejun Heo wrote:
>> Andre Tomt wrote:
>>> Tejun Heo wrote:
>>>> Hello, all.
>>>>
>>>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
>>>
>>> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
>>> patch, seems to be missing in drivers/scsi/Makefile:
>>
>> Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
>> updated tarball is at
>>
>> http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2 
> 
> 
> Seems to work great so far, only knit is that the kernel log does not 
> print it out the NCQ bits as indicated in the README. queue_depth in 
> sysfs do show proper values however, just a backport issue I guess.

It's actually a hiccup introduced by recent selective msg-enable in 
#upstream.  It will be resolved soon.

Thanks.

-- 
tejun
