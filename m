Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVJLPtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVJLPtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVJLPtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:49:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:8677 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964784AbVJLPtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:49:18 -0400
Message-ID: <434D3078.50205@pobox.com>
Date: Wed, 12 Oct 2005 11:49:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com> <434D2DF1.9070709@gentoo.org>
In-Reply-To: <434D2DF1.9070709@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>> I would prefer /proc/via
>> to vanish because it complicates driver needlessly (could you do
>> this in separate patch?).
> 
> 
> I'm working on a user-space app to provide the same info. It's nearly 
> there but lacking some timing info.
> 
> Do you have any suggestions for how I can compute the value of via_clock 
> in userspace? (i.e. some equivalent of system_bus_clock())

A sysfs read-only attribute, associated with the PCI device?

Of course, procfs sure seems a whole lot easier some days...

	Jeff


