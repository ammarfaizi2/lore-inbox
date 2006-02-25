Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWBYS4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWBYS4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWBYS4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:56:04 -0500
Received: from lucidpixels.com ([66.45.37.187]:56532 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1161057AbWBYS4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:56:03 -0500
Date: Sat, 25 Feb 2006 13:55:58 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <liml@rtr.ca>
cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4400A1BF.7020109@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602251355060.4827@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will give 2.6.16-rcX a try shortly, here is the error again (with a 
freshly patched 2.6.15.4) just to rule out any problems with the first 
time that I patched:

[ 1037.451784] ata3: translated op=0x2a ATA stat/err 0x51/04 to SCSI 
SK/ASC/ASCQ 0xb/00/00
[ 1037.451791] ata3: status=0x51 { DriveReady SeekComplete Error }
[ 1037.451796] ata3: error=0x04 { DriveStatusError }
[ 1517.050496] ata3: no sense translation for op=0x2a status: 0x51
[ 1517.050504] ata3: translated op=0x2a ATA stat/err 0x51/00 to SCSI 
SK/ASC/ASCQ 0x3/11/04
[ 1517.050506] ata3: status=0x51 { DriveReady SeekComplete Error }


On Sat, 25 Feb 2006, Mark Lord wrote:

> Justin Piszcz wrote:
>> Second patch fails for me.
> ..
>> Should I be using 2.6.16-rcX?
>
> Mmm... that's what I'm using (plus other patches),
> so, yes.. give that a try.  2.6.16 does seem to
> be shaping up to be a nice kernel.
>
> Cheers
>
