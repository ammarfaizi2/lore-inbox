Return-Path: <linux-kernel-owner+w=401wt.eu-S932935AbWLNVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWLNVeO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbWLNVeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:34:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49733 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934AbWLNVeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:34:13 -0500
Message-ID: <4581C345.2070600@garzik.org>
Date: Thu, 14 Dec 2006 16:33:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061214202854.GM5010@kernel.dk> <20061214204855.GQ5010@kernel.dk> <200612142113.41135.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612142113.41135.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Hi Jens,
> 
> On Thursday 14 December 2006 20:48, Jens Axboe wrote:
>> On Thu, Dec 14 2006, Jens Axboe wrote:
>>>> I'll do that if nobody comes up with anything obvious.
>>> If you can just test 2.6.19-git1, then we'll know if it's the SG_IO
>>> patch again.
>> Actually, you should test 2.6.19-git1 with this patch applied as well.
> 
> 2.6.19-git1 with FUJITA Tomonori's bio-leak fix doesn't break, and hddtemp 
> continues to work fine:
> 
> [root] 21:10 [~] hddtemp /dev/sda /dev/sdb /dev/sdc /dev/sdd
> /dev/sda: WDC WD2500KS-00MJB0: 29°C
> /dev/sdb: WDC WD2500KS-00MJB0: 27°C
> /dev/sdc: Maxtor 6B200M0: 28°C
> /dev/sdd: Maxtor 6B200M0: 26°C

So can you bisect and see which patch broke things?

I do wonder if its the update to sata_nv ADMA.

	Jeff



