Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVHRHyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVHRHyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHRHyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:54:03 -0400
Received: from [202.125.80.34] ([202.125.80.34]:10099 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932110AbVHRHyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:54:00 -0400
Content-class: urn:content-classes:message
Subject: RE: How to support partitions in driver?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 18 Aug 2005 13:17:51 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B3849@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to support partitions in driver?
Thread-Index: AcWjwq/cCTQMFyysTN6j/pyTlajVsAABN9Sg
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Russel,

I have a full-fledged driver working with NO problems. It has been
developed long back.
Now the issue here is to add the partitions support to the existing
driver.

I guess it will involve enough amount of work. If NOT, please provide me
the documentation if available, HOW-TO use the MMC layer.

If the requirement was BIG & bulky what you suggested might have been
apt.
If I can solve it in less effort why go for more effort.
I can always integrate it with main-steam kernel letter. This is the
PEAK time & I am required to submit the patch as soon as possible.

Please understand the reason behind it.

I assure you that I will use the kernel MMC & accomplish what u said
within  next month?
But for now how to implement the partition support in the driver will be
very helpfull.

Thanks & Regards,
Mukund Jampala



>> I have few basic queries regarding my partition implementation in my
Sd
>> driver.
>> Sorry for asking such petty things here. But, somehow it's not
working &
>> I am made to ask it here.
>
>Why don't you use the MMC/SD layer already merged into the kernel
>instead of rewriting your own.  Grab a copy of Andrew Morton's
>kernel, and look at the code in drivers/mmc and include/linux/mmc.
>
>There are three host drivers there already.  I'm sure you can work
>out how to interface the existing framework to your device.
>
>And suddenly you can take advantage of the already existing mmc
>block device support, which does support partitions, and does
>manage to get hot swapping block devices more or less correct.
>(and if it doesn't, it'll be one less driver to fix later.)
>
>--
>Russell King
> Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
> maintainer of:  2.6 Serial core
