Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWJERek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWJERek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWJERek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:34:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15829 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751095AbWJERej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:34:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RYou1kXTozuMW/Q9AfLmapYHI95MZTmKcbsJ6kPeP/HidjyFGYTBMq5e44XuKqmGgJOEQlkSFvFbEsp7+PsCieZrfDq/cN43cW7ldae5glkjA0fQNnl/cbqPmgYRr3VLrF5j3MyKEJryd2vI/eNTEvyrHkJEg9xZFexFONWUmZw=
Message-ID: <5aa69f860610051034r5f7758aelba0a4eee57fe7de8@mail.gmail.com>
Date: Thu, 5 Oct 2006 20:34:37 +0300
From: "=?UTF-8?Q?Fatih_A=C5=9F=C4=B1c=C4=B1?=" <asici.f@gmail.com>
To: "Prakash Punnoor" <prakash@punnoor.de>
Subject: Re: 2.6.19-rc1: forcedeth, nobody cared
Cc: mingo@redhat.com, manfred@colorfullife.com,
       "Linux List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200610050938.10997.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610050938.10997.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> Hi,
>
> subjects say it all. Without irqpoll my nic doesn't work anymore. I added Ingo
> to cc, as my IRQs look different, so it may be a prob of APIC routing or the
> like.
>
> The kernel is patched with reiser4 and acpi_skip_timer_override quirk is
> deactivated (see last link why).
>
> I tried different combinations (dmesg + .config). Differences are mostly pci
> mt init, irqpoll, nforce eth napi, pata/ide amd driver. Last is current
> (working, but with irqpoll)
>
Can you try booting with pci=nomsi ? I have a similar problem with my sound
device:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2503
