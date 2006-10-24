Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWJXPLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWJXPLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWJXPLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:11:11 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:54661 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965154AbWJXPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:11:09 -0400
Date: Tue, 24 Oct 2006 11:10:02 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19-rc2 - Cable detection problem in pata_amd
In-reply-to: <1161698939.22348.33.camel@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Walt H <walt_h@lorettotel.net>,
       linux-ide@vger.kernel.org
Message-id: <200610241110.02413.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <453D5067.9070407@lorettotel.net>
 <1161698939.22348.33.camel@localhost.localdomain>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 October 2006 10:08, Alan Cox wrote:
>Ar Llu, 2006-10-23 am 18:29 -0500, ysgrifennodd Walt H:
>> On bootup, the pata_amd driver mis-detects the cable connected to the
>> 2nd port on my system as 40 wire and sets UDMA/33 for this drive. Prior
>
>Can you stick it in bugzilla.kernel.org and assign it to me. Also attach
>an lspci -vxxx. There is a bug or two somewhere in this area still but
>I'm very busy at the moment with other stuff so don't want your report
>to go in one ear and out of the other in a couple of days then get
>forgotten.
>
That doesn't seem to happen on an nforce2 board here:

hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
hdb: max request size: 512KiB
hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
hdd: max request size: 512KiB
hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, 
UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 hdd2 hdd3
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20

So this might be a chipset problem.  Post the bugzilla # when its been done 
and I'll add this if its revelent.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
