Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161844AbWKIVCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161844AbWKIVCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161845AbWKIVCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:02:12 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:13518 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1161844AbWKIVCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:02:11 -0500
Message-ID: <45539753.7060906@atipa.com>
Date: Thu, 09 Nov 2006 15:02:11 -0600
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
X-OriginalArrivalTime: 09 Nov 2006 21:03:09.0390 (UTC) FILETIME=[75CA66E0:01C70442]
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

It depends on which PCI bus has the issue and which hardware
is using the bus with the issue.

There are several different buses in most machines, and they are
broken out different ways, and the error can only affect one
or 2 devices on a certain part of the bus.

                      Roger
