Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWJXWVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWJXWVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJXWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:21:38 -0400
Received: from dialup-63-108-131-26.nehp.net ([63.108.131.26]:23427 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S1422730AbWJXWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:21:37 -0400
Message-ID: <453E91EF.2060308@lorettotel.net>
Date: Tue, 24 Oct 2006 17:21:35 -0500
From: Walt H <walt_h@lorettotel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060929 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc2 - Cable detection problem in pata_amd
References: <453D5067.9070407@lorettotel.net> <1161698939.22348.33.camel@localhost.localdomain> <200610241110.02413.gene.heskett@verizon.net>
In-Reply-To: <200610241110.02413.gene.heskett@verizon.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Tuesday 24 October 2006 10:08, Alan Cox wrote:
>> Ar Llu, 2006-10-23 am 18:29 -0500, ysgrifennodd Walt H:
>>> On bootup, the pata_amd driver mis-detects the cable connected to the
>>> 2nd port on my system as 40 wire and sets UDMA/33 for this drive. Prior
>> Can you stick it in bugzilla.kernel.org and assign it to me. Also attach
>> an lspci -vxxx. There is a bug or two somewhere in this area still but
>> I'm very busy at the moment with other stuff so don't want your report
>> to go in one ear and out of the other in a couple of days then get
>> forgotten.
>>
> That doesn't seem to happen on an nforce2 board here:
> 
> hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
> UDMA(133)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
> hdb: max request size: 512KiB
> hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
> UDMA(100)
> hdb: cache flushes supported
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
> hdd: max request size: 512KiB
> hdd: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, 
> UDMA(100)
> hdd: cache flushes supported
>  hdd: hdd1 hdd2 hdd3
> hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
> Uniform CD-ROM driver Revision: 3.20
> 
> So this might be a chipset problem.  Post the bugzilla # when its been done 
> and I'll add this if its revelent.

Wouldn't surprise me. This is an AMD MP setup with a 762/768 north/south
bridge.  I suppose it's getting a bit long in the tooth...  No BIOS
updates either...

BTW, bugzilla number is 7411.


