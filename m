Return-Path: <linux-kernel-owner+w=401wt.eu-S1750997AbXAVIQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbXAVIQP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbXAVIQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:16:15 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:59475 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXAVIQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:16:14 -0500
Date: Mon, 22 Jan 2007 09:16:05 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Chr <chunkeey@web.de>, Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070122091605.7aadd678@localhost>
In-Reply-To: <45B40B18.4090500@gmail.com>
References: <20070121152932.6dc1d9fb@localhost>
	<45B3A392.6050609@shaw.ca>
	<20070121202552.14cc29fe@localhost>
	<200701212132.20099.chunkeey@web.de>
	<45B40B18.4090500@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 01:53:21 +0059
Jiri Slaby <jirislaby@gmail.com> wrote:

> >>   7 Seek_Error_Rate         0x000f   083   060   030    Pre-fail  Always       -       204305750
> >>   1 Raw_Read_Error_Rate     0x000f   059   049   006    Pre-fail  Always       -       215927244
> >> 195 Hardware_ECC_Recovered  0x001a   059   049   000    Old_age   Always       -       215927244 
> > 
> > Wow! that HDD is really in a bad condition.
> 
> I don't think so, this seems to be normal for Seagate drives...

I agree.

For Chr: I don't think these big raw-numbers are counters, look at the
normalized values instead, and see that they are greater than TRESH
values (so they are good).

The meaning of raw-numbers is vendor specific.

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
