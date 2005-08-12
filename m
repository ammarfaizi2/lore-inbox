Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVHLOWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVHLOWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVHLOWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:22:25 -0400
Received: from [202.125.86.130] ([202.125.86.130]:21135 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S1751193AbVHLOWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:22:24 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
Date: Fri, 12 Aug 2005 19:52:31 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <C349E772C72290419567CFD84C26E0170A0186@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWeihh8WTWFEovmR1mAWE4yCb1YYQAsm6XA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lennart,

I have an update on this. Please see the message indented inline.

>A few things I would try:
>
>Stick the SD card in a generic cheap USB media reader, and see what the
>kernel thinks of the cards then.  Do both work?

I do NOT have one. I am getting it today.  I will work on it this
weekend?

>You could also use that do dd the first few blocks from the card to see
>what the partition table and fat tables look like, in case your SD
>driver is somehow messing that part up.  By having a copy you can
>compare more easily.

I dumped the 0th sector of SD when formatted on 
	1) CAM &
	2) Windows
The partition table exists on both.
But, the Master Boot Code is NOT present on the CAM formatted SD but is
available on windows formatted SD card.

Can you comment on the Master Boot Code? What is it required on Linux
HOW does windows managed without it? I mean how is Windows able to mount
the SD?

My driver does NOT support partitions? I mean I have implemented it as
alloc_disk(1) & relative first_minor chage obviously.

Is it why I am NOT able to mount the CAM formatted device?
Is this a problem?

Thanks & Regards,
Mukund Jampala
