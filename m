Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUAHFTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 00:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUAHFTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 00:19:48 -0500
Received: from [192.94.94.6] ([192.94.94.6]:3778 "EHLO reloaded.ext.ti.com")
	by vger.kernel.org with ESMTP id S263726AbUAHFTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 00:19:44 -0500
Reply-To: <iqbal2@india.ti.com>
From: "Iqbal" <iqbal2@india.ti.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: removable media revalidation - udev vs. devfs or static /dev
Date: Thu, 8 Jan 2004 10:49:35 +0530
Message-ID: <002501c3d5a7$01f0aa30$ddb7a8c0@ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I feel, the media revalidation issue can be solved by hacking protocol(SCSI
or USB) layer and the respective notification of the same to user space by a
signal.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jens Axboe
Sent: Wednesday, January 07, 2004 4:01 PM
To: Olaf Hering
Cc: Andrey Borzenkov; Andries Brouwer; Greg KH;
linux-hotplug-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static
/dev


On Wed, Jan 07 2004, Olaf Hering wrote:
>  On Wed, Jan 07, Jens Axboe wrote:
>
> > On Wed, Jan 07 2004, Olaf Hering wrote:
> > >  On Wed, Jan 07, Jens Axboe wrote:
> > >
> > > > No need to put it in the kernel, user space fits the bil nicely. I
don't
> > > > see how this would lead to IO errors?
> > >
> > > Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI
ZIP
>         ^^^
>
> "How"? We need a sane way to deal with removeable medias.
> Do you have example code that can be put into the udev distribution?

--
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

