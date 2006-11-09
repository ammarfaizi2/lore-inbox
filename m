Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161846AbWKIVDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161846AbWKIVDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966062AbWKIVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:03:45 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:19406 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S966058AbWKIVDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:03:42 -0500
Message-ID: <455397AE.2040207@atipa.com>
Date: Thu, 09 Nov 2006 15:03:42 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net>
In-Reply-To: <45539699.40105@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 21:04:40.0578 (UTC) FILETIME=[AC249620:01C70442]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Roger Heflin wrote:
>> The failure can manifest itself in many ways, I have
>> only seen it as a read failure, but there should be no
>> reason why it cannot also show as a write failure.
>>
>> It should be in the later vanilla kernels, it won't
>> be in the earlier ones,  I would do a
>> find /lib/modules -name "*edac*" -ls
>>
>> It is a hw issue, either something is running faster that
>> it should be (pci bus set to fast for the given hardware/config)
>> or something is broken.
> The strange thing is that it always occures on the copied data,.. not
> the original (which is on another disk). But wouldn those parity errors
> not occur in general?
> For example al my sha1sums -c sumfile checks are working corretly on the
> original disk :/

Are both disks of the same type and connected to the same
hardware?

Or do they have different physical connections/drivers to the
machine?

                        Roger
