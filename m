Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbVKQO3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbVKQO3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVKQO3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:29:15 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:22093 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750863AbVKQO3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:29:15 -0500
Message-ID: <437C9334.3020606@samwel.tk>
Date: Thu, 17 Nov 2005 15:27:00 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Bradley Chapman <kakadu@gmail.com>, Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
In-Reply-To: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley, Jan,

Bradley Chapman wrote:
> I too have been experiencing some problems with laptop-mode that may
> be similar to what was recently reported here.
> 
> I have a Centrino machine (Sager NP3760, aka Clevo M375E) with a 60GB
> Hitachi TravelStar hard disk running in UDMA5 and 512MB RAM, and on
> occassions I've had random files on my /usr partition overwritten and
> both my /usr and /var filesystems quite thoroughly trashed - with
> these events usually occuring right after I'd been on battery power
> and my hard disk had been spinning up and down regularly.
> 
> All my filesystems are ext3 with journaling active, and none of them
> have been messed with (i.e. resized).

OK, that's the second report then. I'm beginning to worry. :/

Are you seeing any DMA timeout messages in your kernel log?

Also, both reports are on ext3, which might point to an ext3 problem 
with long commit intervals.

Bradley, Jan, since when have these problems been happening? Kernel 
version-wise, I mean?

--Bart
