Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932776AbWHOMm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932776AbWHOMm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWHOMm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:42:26 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:60788 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932776AbWHOMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mmlRZqQV+/EsAXTZRO1cQb4TsD7PsRsNz6S4wM3KFza4FK0OQjU0mA1Hz45yiABSwrCDt6y5iAm72c+FNLB6oyQ234OOjL4rWc0rM/+p8RWeCUTO0ErDnltDH/G0TjGwzGZoPSrXsnyB/Loi1BR5DhFLKkUi8Q9U3+llAjFH6Cs=
Message-ID: <13e988610608150542od63a2ecqcbf8684033d9690f@mail.gmail.com>
Date: Tue, 15 Aug 2006 14:42:25 +0200
From: "Carsten Otto" <carsten.otto@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Daily crashes, incorrect RAID behaviour
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1155646621.24077.270.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
	 <1155646621.24077.270.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rule of thumb (and a good one). If the soft reboot and BIOS cannot
> recover the disk then the disk is the problem. There isn't really
> anything we can tell the drive to do which should make it take a hike
> and ignore a reset sequence.  (Should.. however..)

Makes sense. I will focus my attention on the disks now (which makes
sense not only because of your information).

> > DriveReadySeekComplete (I do not recall the exact words, sorry) for one disk
> Pity the exact text is essential.

Here is the exact message I saw a few weeks ago (posted in here):

ata4: handling error/timeout
ata4: port reset, p_is 0 is 0 pis 0 cmd c017 tf 7f ss 0 se 0
ata4: status=0x50 { DriveReady SeekComplete }
sdd: Current: sense key=0x0
        ASC=0x0 ASCQ=0x0
Info fid=0x0

To my knowledge this time it did not look different at all.

> I assume you've run memtest86 and also checked temperatures look good
> around all the disks.

Of course. I even replaced the mainboard (screwdriver accident..) and
power supply (too weak). And I now know that the sata cables I used at
first did not cause the problems :)

Thanks,
-- 
Carsten Otto
carsten.otto@gmail.com
www.c-otto.de
