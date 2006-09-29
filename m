Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWI2KEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWI2KEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWI2KEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:04:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7842 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932080AbWI2KEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:04:00 -0400
Message-ID: <451CEF8E.2050601@garzik.org>
Date: Fri, 29 Sep 2006 06:03:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Prakash Punnoor <prakash@punnoor.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA status reports update
References: <451CE8EC.1020203@garzik.org> <200609291149.37009.prakash@punnoor.de> <451CED23.1090909@garzik.org> <200609291200.56308.prakash@punnoor.de>
In-Reply-To: <200609291200.56308.prakash@punnoor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Well, how would one debug it w/o hw docs? Or is it possible to compare the 
> patch with a working driver for another chipset?

Well, it is based off of the standard ADMA[1] specification, albeit with 
modifications.  There is pdc_adma.c, which is also based off ADMA.  And 
the author (from NVIDIA) claims that the driver worked at one time, so 
maybe it is simply bit rot that broke the driver.

If I knew the answer, it would be fixed, so the best answer 
unfortunately is "who knows".

I wish I had the time.  But I also wish I had a team of programmers 
working on libata, too ;-)

	Jeff


